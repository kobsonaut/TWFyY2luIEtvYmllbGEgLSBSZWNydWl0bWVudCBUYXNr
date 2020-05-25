//
//  ItemWeather+CoreDataClass.swift
//  WeatherApp
//
//  Created by Kobsonauta on 24/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ItemWeather)
public class ItemWeather: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case name
        case main
        case id
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "ItemWeather", in: managedObjectContext) else {
            fatalError("Failed to decode Weather")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.main = try container.decodeIfPresent(ItemTemperature.self, forKey: .main)
        if let id = try container.decodeIfPresent(Int32.self, forKey: .id) {
            self.id = id
        }
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(main, forKey: .main)
        try container.encode(id, forKey: .id)
    }
}


