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


// MARK: Fonts
extension UIFont {

    private struct Key {
        static let bold = "Lato-Bold"
        static let regular = "Lato-Regular"
        static let light = "Lato-Light"
    }

    static var clientBold: UIFont {
        get {
            return UIFont(name: UIFont.Key.bold, size: 18.0) ?? UIFont.boldSystemFont(ofSize: 18.0)
        }
    }

    static var clientRegular: UIFont {
        get {
            return UIFont(name: UIFont.Key.regular, size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
        }
    }

    static var clientLight: UIFont {
        get {
            return UIFont(name: UIFont.Key.light, size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
        }
    }
}


// MARK: UILabel
extension UILabel {
    func sizeForText(min _min: CGRect, max _max: CGRect) -> CGSize {
        // Remember the current frame
        let old_frame = self.frame

        // Set the max frame
        self.bounds = _max
        self.sizeToFit()

        var cframe = CGRect.zero
        cframe.size = self.bounds.size

        // Reset
        self.bounds = old_frame

        // Checks
        if (cframe.size.height < _min.size.height) {
            cframe.size.height = _min.size.height
        } else if (cframe.size.width > _max.size.width) {
            cframe.size.width = _max.size.width
        }

        if (cframe.size.width < _min.size.width) {
            cframe.size.width = _min.size.width
        } else if (cframe.size.height > _max.size.height) {
            cframe.size.height = _max.size.height
        }

        let size = CGSize(width: ceil(cframe.size.width), height: ceil(cframe.size.height))

        return self.systemLayoutSizeFitting(size)
    }


    func sizeForText() -> CGSize {
        self.sizeForText(min: CGRect.zero, max: self.bounds)
    }
}


// MARK: CodingUserInfoKey
extension CodingUserInfoKey {
   static let context = CodingUserInfoKey(rawValue: "context")
}


// MARK: Double
extension Double {
    var roundedCelcius: String {
        return String(format: "%.f", self) + "°C"
    }

    var roundedFahrenheit: String {
        return String(format: "%.f", self) + "°F"
    }

    var convertedToCelcius: String {
        return String(format: "%.f", (self - 32) / 1.8) + "°C"
    }
}
