//
//  CountryCell.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/30/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Afghanistan (+93)"
        label.font = UIFont(name: "Avenir Next-Regular", size: 14)
        return label
    }()
    func setupViews() {
        addSubview(countryLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]|", views: countryLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: countryLabel)
    }
}
