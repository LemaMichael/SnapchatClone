//
//  ContactCell.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/30/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class ContactCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let fullName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 15)
        label.textColor = UIColor.rgb(red: 22, green: 25, blue: 28)
        label.textAlignment = .left
        label.text = "John Appleseed"
        return label
    }()
    let username: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 11)
        label.textColor = UIColor.rgb(red: 189, green: 195, blue: 201)
        label.textAlignment = .left
        label.text = "AppleseedJohn"
        return label
    }()
    let addTextField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        textField.isUserInteractionEnabled = false
        textField.layer.masksToBounds = true
        //: Making my own border
        textField.layer.cornerRadius = 14
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.rgb(red: 227, green: 208, blue: 239).cgColor
        textField.font = UIFont(name: "Avenir-Heavy", size: 13)
        textField.textColor = UIColor.rgb(red: 140, green: 71, blue: 191)
        textField.textAlignment = .center
        textField.text = "Add"
        //textField.adjustsFontSizeToFitWidth = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.fullName, self.username])
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 234, green: 237, blue: 239)
        return view
    }()
    
    func setupCell() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addTextField.setLeftImage(UIImage(named: "Add Friend")!, padding: 17)
        addSubview(stackView)
        addSubview(addTextField)
        addSubview(borderView)
        //: Centering the Y position for the stackView and addTextField
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        //: Setting the left and right NSLayoutAttribute for the addTextField and stackView
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -12))
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 12))
        //: Setting the addTextField width and height constratins
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 75))
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        //: Setting the left and right NSLayoutAttribute for the addTextField and stackView
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: addTextField, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .left, relatedBy: .equal, toItem: stackView, attribute: .right, multiplier: 1, constant: 0))
        //: Setting the width & height constraints for the border
        addConstraintsWithFormat(format: "H:|[v0]|", views: borderView)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: borderView)
    }
}
