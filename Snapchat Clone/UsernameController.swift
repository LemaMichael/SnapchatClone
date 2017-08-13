//
//  UsernameController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/13/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class UsernameController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    private let purpleButtonColor =  UIColor.rgb(red: 153, green: 87, blue: 159)
    private let grayButtonColor = UIColor.rgb(red: 185, green: 192, blue: 199)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = self
        return scrollView
    }()
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let pickUsernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 19)
        label.text = "Pick a username"
        return label
    }()
    
    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Heavy", size: 12)
        label.textColor = .lightGray
        label.text = "Your username is how friends add you on Snapchat clone."
        return label
    }()
    
    let usernamelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 11)
        label.textColor = .lightGray
        label.text = "USERNAME"
        return label
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.enablesReturnKeyAutomatically = true
        textField.font = UIFont(name: "Avenir-Medium", size: 16)
        textField.setUnderlinedBorder()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = self.grayButtonColor
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    func textFieldDidChange(textField: UITextField) {
        print("text has changed")
    }
    
    func continueButtonTapped() {
        print("Button tapped!")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        setUpNavigationBar(image: "BackButton")
    }
    
   
    
    
    
    
}
