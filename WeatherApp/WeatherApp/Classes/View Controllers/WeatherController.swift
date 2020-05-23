//
//  WeatherController.swift
//  WeatherApp
//
//  Created by Kobsonauta on 21/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import UIKit

final class WeatherController: ViewController {

    // MARK: Constants
    struct Constants {
        static let cell_id = "WeatherCell"
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell_id)
        addSubviewToControllerContent(sub: tableView)

        let mockValues = ["Szczecin", "Warszawa", "Londyn", "Wiedeń", "Amsterdam", "Praga", "Berlin"]
        for value in mockValues {
            self.fetchWeather(for: value)
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(navigationBarButtonPressed))
    }

    // MARK: Helpers
    /// Fetch the weather data
    func fetchWeather(for city: String) {
        let params: [String: String] = ["q": city, "appid": Configuration.Server.APP_ID]
        webserviceCommunicator.request(str_url: Configuration.Server
            .WEATHER_URL,
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

    @objc func navigationBarButtonPressed() {

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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell_id, for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name

        return cell
    }
}
