//
//  WeatherController.swift
//  WeatherApp
//
//  Created by Kobsonauta on 21/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import UIKit

final class WeatherController: ViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Constants
    struct Constants {
        static let cell_id = "WeatherCell"
    }

    // MARK: Members
    var tableView: UITableView = UITableView()
    var items: [String] = ["Szczecin", "Warsaw", "London", "Vienna"]

    override func loadView() {
        super.loadView()

        // Table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell_id)
        addSubviewToControllerContent(sub: tableView)
    }

    // MARK: Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell_id, for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
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
