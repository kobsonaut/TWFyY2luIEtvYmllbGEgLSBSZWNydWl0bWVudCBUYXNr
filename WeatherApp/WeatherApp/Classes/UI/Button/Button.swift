//
//  Button.swift
//  WeatherApp
//
//  Created by Kobsonauta on 23/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import UIKit

protocol ButtonProtocol: class {
    func buttonWasPressed(button: Button,
                          type: Button.BtnType);
}

// MARK: Button
class Button: UIButton {

    // MARK: Constants
    enum BtnType: Int {
        case none = 0
        case add = 1
    }

    // MARK: Members and Properties
    var type = BtnType.none
    weak var delegate: ButtonProtocol? = nil

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Settings
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true

        self.addTarget(self,
                       action: #selector(self.buttonTouchUpInside),
                       for: UIControl.Event.touchUpInside)
    }

    convenience init(frame: CGRect,
                     type: BtnType,
                     color: UIColor,
                     text: String,
                     font: UIFont,
                     textColor: UIColor,
                     radius: CGFloat,
                     observer: ButtonProtocol?) {
        self.init(frame: frame)

        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = color
        self.tintColor = textColor
        self.layer.cornerRadius = radius
        self.type = type
        self.delegate = observer

        // Do some other adjustments
        self.setupButton()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        self.delegate = nil
        self.removeTarget(self,
                          action: #selector(self.buttonTouchUpInside),
                          for: UIControl.Event.touchUpInside)
    }

    open func setupButton() {
        // Change button settings
    }

    // MARK: Helpers
    func change(type: BtnType, text: String, color: UIColor) {
        self.type = type
        self.setTitle(text, for: .normal)
        self.setTitleColor(color, for: .normal)
    }

    // MARK: Button press
    @objc open func buttonTouchUpInside() {
        // Call delegate
        self.buttonPressed()
    }

    open func buttonPressed() {
        if (self.delegate != nil) {
            self.delegate?.buttonWasPressed(button: self,
                                            type: self.type)
        }
    }
}
