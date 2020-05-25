//
//  Parser.swift
//  WeatherApp
//
//  Created by Kobsonauta on 24/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import Foundation
import UIKit

// MARK: Parser
class Parser {

    let jsonDecoder = JSONDecoder()
    func json<T: Decodable>(data: Data, completion: @escaping ResultCallback<T>) {
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context else {
                fatalError("Failed to retrieve context")
            }

            let context = PersistanceService.context
            jsonDecoder.userInfo[codingUserInfoKeyManagedObjectContext] = context

            let result: T = try jsonDecoder.decode(T.self, from: data)
            try context.save()
            OperationQueue.main.addOperation { completion(.success(result)) }

        } catch let error {
            OperationQueue.main.addOperation { completion(.failure(.parseError(error: error))) }
        }
    }
}
