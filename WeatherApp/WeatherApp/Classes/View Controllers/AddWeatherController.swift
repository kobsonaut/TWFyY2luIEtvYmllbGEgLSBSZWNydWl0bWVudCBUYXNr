//
//  AddWeatherController.swift
//  WeatherApp
//
//  Created by Kobsonauta on 23/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import UIKit

protocol AddWeatherControllerProtocol: class {
    func userEnteredNewCityName(city: String)
}

class AddWeatherController: ViewController {

    // MARK: Members
    var addWeatherView: InfoView? = nil
    weak var delegate: AddWeatherControllerProtocol? = nil

    // MARK: Init
    deinit {
        delegate = nil
        addWeatherView = nil
    }

    override func loadView() {
        super.loadView()

        // Settings
        self.controllerContentView.backgroundColor = .clientMain

        // Add weather view
        let add_weather = InfoView(delegate: self,
                                   image: UIImage(named: "icon_weather"))
        self.addWeatherView = add_weather
        addSubviewToControllerContent(sub: add_weather)

        // Navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                            target: self,
                                                            action: #selector(navigationBarButtonPressed))
    }

    // MARK: Button presses
    override func buttonWasPressed(button: Button, type: Button.BtnType) {
        switch (type) {
        case .add:
            if let cityName = addWeatherView?.addCityTextField?.text {
                delegate?.userEnteredNewCityName(city: cityName)
            }
            closeViewController()

        default:
            super.buttonWasPressed(button: button, type: type)
        }
    }

    @objc func navigationBarButtonPressed() {
        closeViewController()
    }

    func closeViewController() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    // MARK: Layout
    override func layoutElements() {
        super.layoutElements()

        if let sub = self.addWeatherView {
            sub.frame = self.controllerContentView.bounds
        }
    }
}
