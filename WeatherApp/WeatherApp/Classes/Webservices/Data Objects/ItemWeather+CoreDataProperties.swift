//
//  ItemWeather+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Kobsonauta on 24/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemWeather> {
        return NSFetchRequest<ItemWeather>(entityName: "ItemWeather")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int32
    @NSManaged public var main: ItemTemperature?

}
