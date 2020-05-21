//
//  Extensions.swift
//  WeatherApp
//
//  Created by Kobsonauta on 21/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import UIKit

// MARK: Colors
extension UIColor {

    private struct Key {
        static let clientMain = "client_blue"
        static let clientText = "client_dark_gray"
        static let clientYellow = "client_light_yellow"
        static let clientRed = "client_light_red"
    }

    static var clientMain: UIColor {
        get {
            return UIColor(named: UIColor.Key.clientMain) ?? UIColor.clear
        }
    }

    static var clientText: UIColor {
        get {
            return UIColor(named: UIColor.Key.clientText) ?? UIColor.clear
        }
    }

    static var clientYellow: UIColor {
        get {
            return UIColor(named: UIColor.Key.clientYellow) ?? UIColor.clear
        }
    }

    static var clientRed: UIColor {
        get {
            return UIColor(named: UIColor.Key.clientRed) ?? UIColor.clear
        }
    }

    static var clientWhite: UIColor {
        get {
            return UIColor.white
        }
    }
}
