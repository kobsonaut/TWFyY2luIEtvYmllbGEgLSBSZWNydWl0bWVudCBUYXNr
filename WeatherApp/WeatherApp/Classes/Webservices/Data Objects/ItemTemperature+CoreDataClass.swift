//
//  ItemTemperature+CoreDataClass.swift
//  WeatherApp
//
//  Created by Kobsonauta on 24/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ItemTemperature)
public class ItemTemperature: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case temp
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "ItemTemperature", in: managedObjectContext) else {
            fatalError("Failed to decode Temperature")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let temp = try container.decodeIfPresent(Double.self, forKey: .temp) {
            self.temp = temp
        }
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(temp, forKey: .temp)
    }
}
