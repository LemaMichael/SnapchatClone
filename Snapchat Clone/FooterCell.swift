//
//  FooterCell.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/30/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class FooterCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let contactsImage: UIImageView = {
        let imageView = UIImageView()
        let calenderImage = UIImage(named: "Contacts")
        imageView.image = calenderImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let contactsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 13.6)
        label.textColor = UIColor.rgb(red: 22, green: 25, blue: 28)
        label.text = "More Snapchatters from My Contacts"
        return label
    }()
    let rightArrow: UIImageView = {
        let imageView = UIImageView()
        let rightArrow = UIImage(named: "Right Arrow")?.withRenderingMode(.alwaysTemplate)
        imageView.image = rightArrow
        imageView.tintColor = UIColor.rgb(red: 142, green: 142, blue: 147)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setupCell() {
        addSubview(contactsImage)
        addSubview(contactsLabel)
        addSubview(rightArrow)
        addConstraintsWithFormat(format: "H:|-12-[v0(20)]-15-[v1]-[v2(15)]-12-|", views: contactsImage, contactsLabel, rightArrow)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: contactsImage)
        addConstraintsWithFormat(format: "V:[v0(13)]", views: rightArrow)
        addConstraint(NSLayoutConstraint(item: contactsImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: contactsLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: rightArrow, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
