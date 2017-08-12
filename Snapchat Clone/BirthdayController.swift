//
//  BirthdayController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/8/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class BirthdayController : UIViewController {
    
    let purpleButtonColor =  UIColor.rgb(red: 153, green: 87, blue: 159)
    let grayButtonColor = UIColor.rgb(red: 185, green: 192, blue: 199)
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 17)
        label.text = "When's your birthday?"
        return label
    }()
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 11)
        label.textColor = .lightGray
        label.text = "BIRTHDAY"
        return label
    }()
    
    let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Avenir-Medium", size: 16)
        textField.setUnderlinedBorder()
        return textField
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = self.grayButtonColor
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        //: Make the button round
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        return button
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.maximumDate = Date()
        
        //: Set mimimumDate to be January 1, 1898
        var minComponents = DateComponents()
        minComponents.year = 1898
        minComponents.month = 1
        minComponents.day = 1
        datePicker.minimumDate = Calendar.current.date(from: minComponents)
        return datePicker
    }()
    
    
    func continueButtonTapped() {
        print("Continue button tapped")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(questionLabel)
        view.addSubview(birthdayLabel)
        view.addSubview(birthdayTextField)
        view.addSubview(continueButton)
        view.addSubview(datePicker)
        setUpViews()
    }
    
    func setUpViews() {
        let space = UIScreen.main.bounds.height / 5
        view.addConstraintsWithFormat(format: "H:|-65-[v0]-65-|", views: questionLabel)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: birthdayLabel)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: birthdayTextField)
        view.addConstraintsWithFormat(format: "H:|-68-[v0]-68-|", views: continueButton)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: datePicker)

        view.addConstraintsWithFormat(format: "V:[v0(35)]-15-[v1(11)][v2(35)]-\(space)-[v3(44)]-25-[v4(216)]|", views: questionLabel, birthdayLabel, birthdayTextField, continueButton,datePicker)
    }
    
}
