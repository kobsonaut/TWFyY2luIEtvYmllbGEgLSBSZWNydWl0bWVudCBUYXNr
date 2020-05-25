//
//  WeatherController.swift
//  WeatherApp
//
//  Created by Kobsonauta on 21/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import UIKit
import CoreData

final class WeatherController: ViewController, AddWeatherControllerProtocol {

    // MARK: Constants
    struct Constants {
        static let cell_id = "WeatherCell"
        static let row_height = CGFloat(80.0)
        static let weather_unit = "imperial"
    }

    // MARK: Members
    private var webserviceCommunicator = WebserviceCommunicator()
    var items = [ItemWeather]()
    var tableView: UITableView = UITableView()
    var weatherTimer: Timer?

    // MARK: Life cycle
    override func loadView() {
        super.loadView()

        // Settings
        self.title = NSLocalizedString("lang_weather_title", comment: "")

        // Table view
        createTableView()

        // Navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(navigationBarRightButtonPressed))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("lang_weather_navbar_title", comment: ""),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(navigationBarLeftButtonPressed))

        fetchStoredLocations()
        weatherTimer = Timer.scheduledTimer(timeInterval: 3600,
                                            target: self,
                                            selector: #selector(fetchWeatherData),
                                            userInfo: nil,
                                            repeats: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        weatherTimer?.invalidate()
    }

    // MARK: Helpers
    func createTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clientYellow
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Constants.cell_id)
        addSubviewToControllerContent(sub: tableView)
    }

    @objc func navigationBarRightButtonPressed() {
        let vc = ServiceManager.shared.addWeatherController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc,
                                                      animated: true)
    }

    @objc func navigationBarLeftButtonPressed() {
        let useCelciusUnits = UserDefaults.standard.bool(forKey: Configuration.Settings.useCelciusUnits)
        UserDefaults.standard.set(!(useCelciusUnits), forKey: Configuration.Settings.useCelciusUnits)
        self.tableView.reloadData()
    }

    @objc func fetchWeatherData() {
        let cityNames = items.compactMap { $0.name }
        for city in cityNames {
            self.userEnteredNewCityName(city: city)
        }
    }

    func fetchStoredLocations() {
        let fetchRequest: NSFetchRequest<ItemWeather> = ItemWeather.fetchRequest()
        do {
            let weatherArray = try PersistanceService.context.fetch(fetchRequest)
            if weatherArray.isEmpty {
                self.addTestData()
            } else {
                self.items = weatherArray
                self.tableView.reloadData()
            }
        } catch {
            print("Error saving the managed object context")
        }
    }

    private func addTestData() {
        let cities = ["Szczecin", "Warsaw", "Berlin", "Londyn", "Paris"]
        for city in cities {
            self.userEnteredNewCityName(city: city)
        }
    }

    // MARK: AddWeatherControllerProtocol
    func userEnteredNewCityName(city: String) {
        let params: [String: String] = ["q": city, "appid": Configuration.Server.APP_ID, "units": Constants.weather_unit]
        self.webserviceCommunicator.request(str_url: Configuration.Server.WEATHER_URL,
                                            params: params,
                                            completion: { (result: Result<ItemWeather, NetworkError>) in
                                                switch result {
                                                case .failure(let error):
                                                    dump(error)
                                                case .success(let weather):
                                                    // Add weather forecast only if the city is not on the list
                                                    let containsCity = self.items.filter { $0.name == city }
                                                    if containsCity.isEmpty {
                                                        self.items.append(weather)
                                                        self.tableView.reloadData()
                                                    } else {
                                                        PersistanceService.context.delete(weather)
                                                        PersistanceService.updateTemperature(with: weather)
                                                        PersistanceService.saveContext()
                                                    }
                                                }
        })
    }

    // MARK: Layout
    override func layoutElements() {
        super.layoutElements()

        var cframe = CGRect.zero

        let sub = self.tableView
        cframe = self.controllerContentView.bounds
        sub.frame = cframe
    }
}

 
extension WeatherController: UITableViewDataSource, UITableViewDelegate {
    // MARK: Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell_id, for: indexPath) as? TableViewCell {
            cell.updateData(item: items[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.row_height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let weather_location = items[indexPath.row]
            items.remove(at: indexPath.row)
            PersistanceService.context.delete(weather_location)
            PersistanceService.saveContext()
            tableView.reloadData()
        }
    }
}
