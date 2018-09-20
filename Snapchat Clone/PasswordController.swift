//
//  PasswordController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/15/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit


class PasswordController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    static var username: String!
    private let purpleButtonColor =  UIColor.rgb(red: 153, green: 87, blue: 159)
    private let grayButtonColor = UIColor.rgb(red: 185, green: 192, blue: 199)
    private var bottomConstraint: NSLayoutConstraint?
    private var isButtonTapped = false
    private var buttonyYposition: CGFloat!
    private var difference: CGFloat!

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
    
    let setPasswordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 19)
        label.text = "Set a Password"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = "Your password should be at least 8 characters."
        return label
    }()
    
    let passwordlabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 11)
        label.textColor = .lightGray
        label.text = "PASSWORD"
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.enablesReturnKeyAutomatically = true
        //: Hide emoji keyboard
        textField.keyboardType = .asciiCapable
        //: Secure text is enabled
        textField.isSecureTextEntry = true
        textField.font = UIFont(name: "Avenir-Medium", size: 16)
        textField.setUnderlinedBorder()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.rightViewMode = UITextFieldViewMode.whileEditing
        textField.delegate = self
        return textField
    }()
    
    lazy var showAndHideButton: UIButton = {
        let button = UIButton(type: .system)
        //: Need to set the frame of the button
        button.contentVerticalAlignment = .bottom
        button.frame = CGRect(x: 0, y: 0, width: 28, height: 25)
        button.titleLabel?.sizeToFit()
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitle("Show", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 11)
        button.addTarget(self, action: #selector(showAndHideTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        button.backgroundColor = self.grayButtonColor
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        //: Make button round
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        return button
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Medium", size: 12)
        //: Faint red color
        label.textColor = UIColor.rgb(red: 239, green: 63, blue: 90)
        label.text = "Username must not be same as password."
        label.isHidden = true
        return label
    }()
    
    //: MARK: - Button Actions
    func continueButtonTapped() {
        guard continueButton.backgroundColor == purpleButtonColor else {
            return
        }
        //: If we are here then the password is valid
        self.navigationController?.pushViewController(EmailController(), animated: false)
    }
    
    func showAndHideTapped() {
        if !isButtonTapped{
            passwordTextField.isSecureTextEntry = false
            showAndHideButton.setTitle("Hide", for: .normal)
            isButtonTapped = true
        } else{
            passwordTextField.isSecureTextEntry = true
            showAndHideButton.setTitle("Show", for: .normal)
            isButtonTapped = false
        }
    }
    
    //: MARK: - scrollViewDidScroll
    //: FIXME: Find a better way to do this
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset: CGFloat = -scrollView.contentOffset.y
        if (difference != nil) {
            //: For iphone 5 or below
            if UIScreen.main.bounds.height < 667 {
                //: The added numbers after the difference is the height, which were written for the constraints
                let percentage: CGFloat = (offset) / (difference)
                resultLabel.alpha = (1 - percentage)
                passwordTextField.alpha = 1.0 - ((offset) / (difference + 45 + 50))
                passwordlabel.alpha = 1.0 - ((offset) / (difference + 56 + 50))
                descriptionLabel.alpha = 1.0 - ((offset) / (difference + 105 + 50))
                setPasswordLabel.alpha = 1.0 - ((offset) / (difference + 116 + 50))
            } else {
                //: For iphone 6 and above
                let percentage: CGFloat = (offset) / (2 * difference)
                resultLabel.alpha = (1 - percentage)
                passwordTextField.alpha = 1.0 - ((offset) / (2 * difference + 45 + 50))
                passwordlabel.alpha = 1.0 - ((offset) / (2 * difference + 56 + 50))
                descriptionLabel.alpha = 1.0 - ((offset) / (2 * difference + 105 + 50))
                setPasswordLabel.alpha = 1.0 - ((offset) / (2 * difference + 116 + 50))
            }
        }
    }
    
    //: MARK: - Text Field methods
    func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        if !text.isEmpty {
            showAndHideButton.isHidden = false
            resultLabel.isHidden = true
            if text == PasswordController.username {
                resultLabel.isHidden = false
                continueButton.backgroundColor = grayButtonColor
            } else if text.count >= 8 {
                continueButton.backgroundColor = purpleButtonColor
            } else {
                continueButton.backgroundColor = grayButtonColor
            }
        } else {
            //: The text is empty
            showAndHideButton.isHidden = true
            continueButton.backgroundColor = grayButtonColor
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard continueButton.backgroundColor == purpleButtonColor else {
            return false
        }
        //: If we are here then the password is valid
        self.navigationController?.pushViewController(EmailController(), animated: false)
        return true
    }
    
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar(leftImage: "BackButton")
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.automaticallyAdjustsScrollViewInsets = false
        
        contentView.addSubview(setPasswordLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(passwordlabel)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(resultLabel)
        view.addSubview(continueButton)
        
        setupViews()
        //: Add a button to the right side of text field.
        passwordTextField.rightView = showAndHideButton
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    //: MARK: - Adjust views
    func setupViews() {
        let screenCenter = UIScreen.main.bounds.height / 8
        //: ScrollView & contentView constraints
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: contentView)
        scrollView.addConstraintsWithFormat(format: "V:|[v0]|", views: contentView)
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0))
        
        contentView.addConstraintsWithFormat(format: "H:|-75-[v0]-75-|", views: setPasswordLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: descriptionLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: passwordlabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: passwordTextField)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: resultLabel)
        
        contentView.addConstraintsWithFormat(format: "V:|-\(screenCenter)-[v0(30)][v1(40)]-15-[v2(11)]-3-[v3(35)]-5-[v4(35)]", views: setPasswordLabel, descriptionLabel, passwordlabel, passwordTextField, resultLabel)
        
        //: Constraints for the continue button
        view.addConstraintsWithFormat(format: "H:|-68-[v0]-68-|", views: continueButton)
        view.addConstraintsWithFormat(format: "V:[v0(44)]", views: continueButton)
        bottomConstraint = NSLayoutConstraint(item: continueButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -(216 + 25))
        view.addConstraint(bottomConstraint!)
    }
    
    //: MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passwordTextField.becomeFirstResponder()
    }
    //: MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        buttonyYposition = -continueButton.frame.origin.y
        let height = self.scrollView.frame.height
        difference = height + buttonyYposition
    }
    
    //: MARK: - Handle Keyboard Notification
    func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect
            bottomConstraint?.constant = -(keyboardFrame!.height + 25)
        }
    }
    
    //: Hide the status Bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
