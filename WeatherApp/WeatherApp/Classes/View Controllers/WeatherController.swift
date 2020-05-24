//
//  WeatherController.swift
//  WeatherApp
//
//  Created by Kobsonauta on 21/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import UIKit

final class WeatherController: ViewController, AddWeatherControllerProtocol {

    // MARK: Constants
    struct Constants {
        static let cell_id = "WeatherCell"
        static let row_height = CGFloat(80.0)
    }

    // MARK: Members
    private var webserviceCommunicator = WebserviceCommunicator()
    var items = [ItemWeather]()
    var tableView: UITableView = UITableView()

    // MARK: Life cycle
    override func loadView() {
        super.loadView()

        // Settings
        self.title = "Clima"

        // Table view
        createTableView()

        // Navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(navigationBarButtonPressed))
    }

    // MARK: Helpers
    func createTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clientYellow
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Constants.cell_id)
        addSubviewToControllerContent(sub: tableView)
    }

    @objc func navigationBarButtonPressed() {
        let vc = ServiceManager.shared.addWeatherController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc,
                                                      animated: true)
    }

    // MARK: AddWeatherControllerProtocol
    func userEnteredNewCityName(city: String) {
        let params: [String: String] = ["q": city, "appid": Configuration.Server.APP_ID]
        self.webserviceCommunicator.request(str_url: Configuration.Server.WEATHER_URL,
                                            params: params,
                                            completion: { (result: Result<ItemWeather, NetworkError>) in
                                                switch result {
                                                case .failure(let error):
                                                    dump(error)
                                                case .success(let weather):
                                                    self.items.append(weather)
                                                    dump(weather)
                                                    self.tableView.reloadData()
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
}
