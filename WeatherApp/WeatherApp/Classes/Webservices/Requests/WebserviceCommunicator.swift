//
//  WebserviceCommunicator.swift
//  WeatherApp
//
//  Created by Kobsonauta on 21/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case dataMissing
    case invalidUrl
    case parseError(error: Error)
    case responseError(error: Error)
}

typealias ResultCallback<T> = (Result<T, NetworkError>) -> Void

// MARK: WebserviceCommunicator
class WebserviceCommunicator {

    // MARK: Members
    private let urlSession: URLSession
    private let parser: Parser

    // MARK: Init
    init(urlSession: URLSession = URLSession(configuration: .default), parser: Parser = Parser()) {
        self.urlSession = urlSession
        self.parser = parser
    }

    // MARK: Networking
    func request<T: Decodable>(str_url: String, params: [String: String], completion: @escaping ResultCallback<T>) {

        var components = URLComponents(string: str_url)
        components?.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        guard let url = components?.url else {
            OperationQueue.main.addOperation({ completion(.failure(.invalidUrl)) })
            return
        }

        let request = URLRequest(url: url)
        let task = urlSession.dataTask(with: request) { [unowned self] (data, response, error) in

            if let error = error {
                OperationQueue.main.addOperation({ completion(.failure(.responseError(error: error))) })
                return
            }

            guard let data = data else {
                OperationQueue.main.addOperation({ completion(.failure(.dataMissing)) })
                return
            }

            self.parser.json(data: data, completion: completion)
        }

        task.resume()
    }
}


// MARK: Parser
struct Parser {
    let jsonDecoder = JSONDecoder()
    func json<T: Decodable>(data: Data, completion: @escaping ResultCallback<T>) {
        do {
            let result: T = try jsonDecoder.decode(T.self, from: data)
            OperationQueue.main.addOperation { completion(.success(result)) }

        } catch let error {
            OperationQueue.main.addOperation { completion(.failure(.parseError(error: error))) }
        }
    }
}
