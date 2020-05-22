//
//  ItemWeather.swift
//  WeatherApp
//
//  Created by Kobsonauta on 21/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import Foundation

struct ItemWeather: Codable {
    var id: Int
    var name: String
    var main: ItemTemperature
}

struct ItemTemperature: Codable {
    var temp: Double?
}
