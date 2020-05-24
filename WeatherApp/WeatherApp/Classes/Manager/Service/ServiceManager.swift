//
//  ServiceManager.swift
//  WeatherApp
//
//  Created by Kobsonauta on 21/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import Foundation

// MARK: ServiceManager
final class ServiceManager {

    // MARK: Properties and Members
    static let shared = ServiceManager()

    // MARK: Init
    private init() {

    }
}

extension ServiceManager {
    func homeController() -> WeatherController {
        let vc = WeatherController()
        return vc
    }

    func addWeatherController() -> AddWeatherController {
        let vc = AddWeatherController()
        return vc
    }
}
