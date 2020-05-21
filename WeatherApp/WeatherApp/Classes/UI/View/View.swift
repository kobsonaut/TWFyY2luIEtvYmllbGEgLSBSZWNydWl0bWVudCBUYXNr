//
//  View.swift
//  WeatherApp
//
//  Created by Kobsonauta on 21/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import UIKit

open class View: UIView {

    // MARK: Init
    public convenience init() {
        self.init(frame: .zero)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        // Initialize the view
        self.initializeView()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open func initializeView() {
        autoresizingMask = UIView.AutoresizingMask(rawValue: 0)
        backgroundColor = .white
        clipsToBounds = true
    }

    deinit {

    }
}
