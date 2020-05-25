//
//  ClientConstants.swift
//  WeatherApp
//
//  Created by Kobsonauta on 22/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import Foundation

class Configuration {

    // MARK: Constants
    struct Server {
        static let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
        static let APP_ID = "e6a799315fe33235d798a65c2f1097a2"
    }

    struct Settings {
        static let useCelciusUnits = "useCelciusUnits"
    }
}
