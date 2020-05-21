//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kobsonauta on 21/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import UIKit

// MARK: ViewController
open class ViewController: UIViewController {

    // MARK: Members
    private var controllerView: ControllerView {
        get {
            if let view = self.view as? ControllerView {
                return view
            }

            let v = ControllerView()
            self.view = v
            return v
        }
    }

    // MARK: Init
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    public override init(nibName _nib: String?, bundle _bundle: Bundle?) {
        super.init(nibName: _nib, bundle: _bundle)

        edgesForExtendedLayout = []

        // Initialize stuff
        self.initControllerValues()
    }

    public required init?(coder _decoder: NSCoder) {
        super.init(coder: _decoder)
    }

    open func initControllerValues() {

    }

    // MARK: Getter / Setter
    public var controllerHeaderView: UIView {
        get {
            return self.controllerView.header
        }
    }

    public var controllerContentView: UIView {
        get {
            return self.controllerView.content
        }
    }

    public var controllerBottomView: UIView {
        get {
            return self.controllerView.bottom
        }
    }

    open func addSubviewToControllerHeader(sub: UIView?) {
        if sub == nil {
            return
        }

        // Add
        self.controllerHeaderView.addSubview(sub!)
    }

    open func addSubviewToControllerContent(sub: UIView?) {
        if sub == nil {
            return
        }

        // Add
        self.controllerContentView.addSubview(sub!)
    }

    open func addSubviewToControllerBottom(sub: UIView?) {
        if sub == nil {
            return
        }

        // Add
        self.controllerBottomView.addSubview(sub!)
    }

    // MARK: Creation
    open override func loadView() {
        if ( self.isViewLoaded == false ) {
            self.view = ControllerView()

            // Set the size
            var bounds = UIScreen.main.bounds
            bounds.size.height = 0
            self.controllerView.header.bounds = bounds
            self.controllerView.content.bounds = bounds
            self.controllerView.bottom.bounds = bounds

            // Configure
            self.loadHeader(view: self.controllerView.header)
            self.loadBottom(view: self.controllerView.bottom)
        }
    }

    open func loadHeader(view _header:UIView) {
        // Update size or some other stuff
    }

    open func loadBottom(view _bottom:UIView) {
        // Update size or some other stuff
    }

    // MARK: Layout
    open override func viewDidLayoutSubviews() {
        // Layout
        layoutElements()
    }

    open func layoutElements() {
        // Layout
    }
}


// MARK: - ControllerView
open class ControllerView: View {

    // MARK: Members
    public var header = View()
    public var content = View()
    public var bottom = View()

    // MARK: Init
    public convenience init() {
        self.init(frame: .zero)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Set the colors
        backgroundColor = .clientWhite
        header.backgroundColor = .clientWhite
        content.backgroundColor = .clientWhite
        bottom.backgroundColor = .clientWhite

        self.addSubview(header)
        self.addSubview(content)
        self.addSubview(bottom)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open override func layoutSubviews() {
        let bounds = self.bounds
        var cframe = CGRect.zero
        var calculated_y = CGFloat(0)
        var sub: UIView? = nil

        sub = self.header
        if sub != nil {
            cframe = bounds
            cframe.origin.y = calculated_y
            cframe.size.height = sub!.bounds.size.height
            sub?.frame = cframe

            calculated_y = max(calculated_y, cframe.origin.y + cframe.size.height)
        }
        sub = nil

        sub = self.content
        if sub != nil {
            cframe = bounds
            cframe.origin.y = calculated_y
            cframe.size.height = bounds.size.height - cframe.origin.y - self.bottom.bounds.size.height
            sub?.frame = cframe

            calculated_y = max(calculated_y, cframe.origin.y + cframe.size.height)
        }
        sub = nil;

        sub = self.bottom
        if sub != nil {
            cframe = bounds
            cframe.origin.y = calculated_y
            cframe.size.height = sub!.bounds.size.height
            sub?.frame = cframe

            calculated_y = max(calculated_y, cframe.origin.y + cframe.size.height)
        }
        sub = nil
    }
}
