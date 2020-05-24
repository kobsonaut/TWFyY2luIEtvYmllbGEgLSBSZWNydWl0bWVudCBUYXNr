//
//  InfoView.swift
//  WeatherApp
//
//  Created by Kobsonauta on 23/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import UIKit

// MARK: InfoView
class InfoView: UIView {

    // MARK: Constants
    struct Constants {
        static let textfield_height = CGFloat(40.0)
        static let button_height = CGFloat(50.0)
    }

    // MARK: Members and Properties
    var imageView: UIImageView? = nil
    var addCityTextField: UITextField? = nil
    var addButton: Button? = nil

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(delegate: ButtonProtocol?,
                     image: UIImage?) {
        self.init(frame: CGRect.zero)

        // Image view
        let imgv = UIImageView(image: image)
        imgv.contentMode = .scaleAspectFit
        self.imageView = imgv
        self.addSubview(imgv)

        // Text Field
        let tf = UITextField()
        tf.backgroundColor = UIColor.clientWhite
        tf.textColor = UIColor.clientMain
        tf.layer.cornerRadius = 5.0
        self.addCityTextField = tf
        self.addSubview(tf)

        // Add button
        let btn = Button(frame: CGRect.zero,
                         type: .add,
                         color: UIColor.clientMain,
                         text: NSLocalizedString("lang_add_weather_button_title",
                         comment: ""),
                         font: UIFont.clientBold.withSize(24.0),
                         textColor: UIColor.clientWhite,
                         radius: 0.0,
                         observer: delegate)

        self.addButton = btn
        self.addSubview(btn)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        self.imageView = nil
        self.addCityTextField = nil
        self.addButton = nil
    }

    // MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()

        var cframe = CGRect.zero
        var temp_y = CGFloat(0.0)

        let cbounds = self.bounds
        let padding_x = CGFloat(20.0)
        let padding_y = cbounds.size.height * 0.1
        let image_side = cbounds.size.width * 0.3
        let image_size = CGSize(width: image_side, height: image_side)

        if let sub = self.imageView {
            cframe.size = image_size
            cframe.origin.y = padding_y * 2
            cframe.origin.x = (cbounds.size.width - cframe.size.width) * 0.5
            sub.frame = cframe

            temp_y = cframe.origin.y + cframe.size.height + padding_y * 0.5
        }

        if let sub = self.addCityTextField {
            cframe = sub.frame
            cframe.size.width = cbounds.size.width - padding_x * 2
            cframe.size.height = Constants.textfield_height
            cframe.origin.x = (cbounds.size.width - cframe.size.width) * 0.5
            cframe.origin.y = temp_y
            sub.frame = cframe

            temp_y = cframe.origin.y + cframe.size.height + padding_y * 0.25
        }

        if let sub = self.addButton,
            sub.isHidden == false {
            cframe.size.width = cbounds.size.width - padding_x * 2
            cframe.size.height = Constants.button_height
            cframe.origin.x = padding_x
            cframe.origin.y = temp_y
            sub.frame = cframe
        }
    }
}
