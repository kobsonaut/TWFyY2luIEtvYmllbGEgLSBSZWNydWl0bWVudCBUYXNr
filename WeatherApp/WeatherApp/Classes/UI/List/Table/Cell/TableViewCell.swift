//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by Kobsonauta on 24/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import UIKit

// MARK: TableViewCell
class TableViewCell: UITableViewCell {

    // MARK: Members and Properties
    var titleLabel: UILabel? = nil
    var descriptionLabel: UILabel? = nil

    // MARK: Init
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);

        // Additional adjustments
        self.initalizeCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func initalizeCell() -> () {
        // Settings
        self.contentView.backgroundColor = UIColor.clientYellow
        self.selectionStyle = .none

        // Title label
        var label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.clientMain
        label.font = UIFont.clientBold.withSize(24.0)
        label.textAlignment = .left
        self.titleLabel = label
        self.contentView.addSubview(label)

        // Description label
        label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.clientMain
        label.font = UIFont.clientRegular.withSize(24.0)
        label.textAlignment = .right
        self.descriptionLabel = label
        self.contentView.addSubview(label)
    }

    open override func prepareForReuse() {
        super.prepareForReuse()

        self.titleLabel?.text = nil
        self.descriptionLabel?.text = nil
    }

    // MARK: Update
    open func updateData(item: ItemWeather) -> () {
        self.titleLabel?.text = item.name
        if let temp = item.main?.temp {
            if UserDefaults.standard.bool(forKey: Configuration.Settings.useCelciusUnits) == true {
                self.descriptionLabel?.text = temp.convertedToCelcius
            } else {
                self.descriptionLabel?.text = temp.roundedFahrenheit
            }
        }

        self.layoutSubviews()
    }

    // MARK: Layouting
    open override func layoutSubviews() {
        super.layoutSubviews()

        //Layout
        self.layoutCell(bounds: self.contentView.bounds)
    }

    open func layoutCell(bounds: CGRect) -> () {
        var cframe = CGRect.zero
        let padding_x = CGFloat(20.0)
        let cbounds = bounds

        if let sub = self.titleLabel,
            sub.isHidden == false {
            cframe = cbounds
            cframe.size.height = sub.sizeForText().height
            cframe.size.width = cbounds.size.width * 0.5
            cframe.origin.x = padding_x
            cframe.origin.y = (cbounds.size.height - cframe.size.height) * 0.5
            sub.frame = cframe
        }

        if let sub = self.descriptionLabel,
            sub.isHidden == false {
            cframe = cbounds
            cframe.size.height = sub.sizeForText().height
            cframe.size.width = cbounds.size.width * 0.3
            cframe.origin.x = cbounds.size.width - cframe.size.width - padding_x
            cframe.origin.y = (cbounds.size.height - cframe.size.height) * 0.5
            sub.frame = cframe
        }
    }
}

