//
//  ItemTemperature+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Kobsonauta on 24/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemTemperature {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemTemperature> {
        return NSFetchRequest<ItemTemperature>(entityName: "ItemTemperature")
    }

    @NSManaged public var temp: Double

}
