//
//  PhoneController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/15/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class PhoneController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    private let purpleButtonColor =  UIColor.rgb(red: 153, green: 87, blue: 159)
    private let grayButtonColor = UIColor.rgb(red: 185, green: 192, blue: 199)
    private let faintRedColor = UIColor.rgb(red: 239, green: 63, blue: 90)
    private var bottomConstraint: NSLayoutConstraint?
    private var buttonyYposition: CGFloat!
    private var difference: CGFloat!
    private let defaultResult = "We'll send you an SMS verification code."
    private let errorMessage = "That's not a valid mobile number!"
    static var areaCode = "US +1"
    static var hasValidEmail = false
    
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
    
    let setNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Medium", size: 19)
        label.text = "What's your mobile number?"
        return label
    }()
    
    let emailButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 11.5)
        let lightBlue = UIColor.rgb(red: 21, green: 126, blue: 251)
        button.setTitleColor(lightBlue, for: .normal)
        button.setTitle("Sign up with email instead", for: .normal)
        button.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 11)
        label.textColor = .lightGray
        label.text = "MOBILE NUMBER"
        return label
    }()
    
    lazy var numberTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.font = UIFont(name: "Avenir-Medium", size: 18)
        textField.setUnderlinedBorder()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.leftViewMode = UITextFieldViewMode.always
        textField.delegate = self
        return textField
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
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Medium", size: 12)
        //: Faint red color
        label.textColor = UIColor.rgb(red: 21, green: 25, blue: 28)
        label.text = self.defaultResult
        return label
    }()
    
    lazy var areaContainer: UIView = {
        let view = UIView()
        //: I know the height of the text field is 35 points
        view.frame = CGRect(x: 0, y: 0, width: 65, height: 35)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var areaCodeButton: UIButton = {
        let button = UIButton(type: .system)
        let lightBlue = UIColor.rgb(red: 21, green: 126, blue: 251)
        button.setTitleColor(lightBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Mediumm", size: 18)
        button.titleLabel?.sizeToFit()
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(areaButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //: MARK: - Button Actions
    func continueButtonTapped() {
        guard let text = numberTextField.text, !text.isEmpty, continueButton.backgroundColor != grayButtonColor else {
            //: Don't do anything if the text is empty and continueButton is a grayButtonColor
            return
        }
        if isValidNumber(number: checkNumber(phoneNumber: text)) {
            print("We are good to go: Probably do some animation here later")
            //: If we are here then the phone number is valid
            ConfirmationController.phoneNumber = text
            self.navigationController?.pushViewController(ConfirmationController(), animated: false)
        } else {
            resultLabel.text = errorMessage
            resultLabel.textColor = faintRedColor
        }
    }
    func emailButtonTapped() {
        //: Leaving back to the emailController
        popCurrentView()
    }
    func areaButtonTapped() {
        self.navigationController?.pushViewController(CountryController(), animated: false)
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
                numberTextField.alpha = 1.0 - ((offset) / (difference + 45 + 50))
                numberLabel.alpha = 1.0 - ((offset) / (difference + 56 + 50))
                emailButton.alpha = 1.0 - ((offset) / (difference + 105 + 50))
                setNumberLabel.alpha = 1.0 - ((offset) / (difference + 116 + 50))
            } else {
                //: For iphone 6 and above
                let percentage: CGFloat = (offset) / (2 * difference)
                resultLabel.alpha = (1 - percentage)
                numberTextField.alpha = 1.0 - ((offset) / (2 * difference + 45 + 50))
                numberLabel.alpha = 1.0 - ((offset) / (2 * difference + 56 + 50))
                emailButton.alpha = 1.0 - ((offset) / (2 * difference + 105 + 50))
                setNumberLabel.alpha = 1.0 - ((offset) / (2 * difference + 116 + 50))
            }
        }
    }
    
    //: MARK: - Text Field methods
    func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            continueButton.backgroundColor = grayButtonColor
            return
        }
        if resultLabel.text == errorMessage {
            resultLabel.text = defaultResult
            resultLabel.textColor = UIColor.rgb(red: 21, green: 25, blue: 28)
        }
        continueButton.backgroundColor = getLength(number: text) >= 8 ? purpleButtonColor : grayButtonColor
    }
    
    //: MARK: - Format number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let number = textField.text else {
            return false
        }
        let numberLength = getLength(number: number)
        if numberLength == 15 && range.length == 0 {
            return false
        }
        if numberLength == 3 {
            let number = formatNumber(number)
            textField.text = NSString(format:"(%@) ", number) as String
            if range.length > 0 {
                let index: String.Index = number.index(number.startIndex, offsetBy: 3)
                textField.text = NSString(format:"%@", number.substring(to: index)) as String
            }
        } else if numberLength == 6 {
            let number = formatNumber(number)
            let index: String.Index = number.index(number.startIndex, offsetBy: 3)
            textField.text = NSString(format:"(%@) %@-", number.substring(to: index), number.substring(from: index)) as String
            if range.length > 0 {
                textField.text = NSString(format:"(%@) %@", number.substring(to: index), number.substring(from: index)) as String
            }
        }
        return true
    }
    
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let array = navigationController!.viewControllers
        for i in array {
            print("The current item in the navigation stack is: \(i)")
        }
        //: This is only if the user has prefered using email first
        if PhoneController.hasValidEmail {
            emailButton.isHidden = true
            let rightBarButton = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(robotVerification))
            rightBarButton.tintColor = UIColor.rgb(red: 206, green: 212, blue: 218)
            rightBarButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 15)!], for: .normal)
            self.navigationItem.rightBarButtonItem = rightBarButton
        }
        
        //: Hide the back bar button item
        setUpNavigationBar(leftImage: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.automaticallyAdjustsScrollViewInsets = false
        
        contentView.addSubview(setNumberLabel)
        contentView.addSubview(emailButton)
        contentView.addSubview(numberLabel)
        contentView.addSubview(numberTextField)
        contentView.addSubview(resultLabel)
        view.addSubview(continueButton)
        
        setUpViews()
        setUpAreaContainer()
        //: Add a container the right side of text field.
        numberTextField.leftView = areaContainer
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    //: MARK: - Skip Action
    func robotVerification() {
        self.navigationController?.pushViewController(VerificationController(), animated: false)
    }
    
    //: MARK: - Adjust views
    func setUpViews() {
        let screenCenter = UIScreen.main.bounds.height / 8
        //: ScrollView & contentView constraints
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: contentView)
        scrollView.addConstraintsWithFormat(format: "V:|[v0]|", views: contentView)
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0))
        
        contentView.addConstraintsWithFormat(format: "H:|-75-[v0]-75-|", views: setNumberLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: emailButton)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: numberLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: numberTextField)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: resultLabel)
        
        contentView.addConstraintsWithFormat(format: "V:|-\(screenCenter)-[v0(55)][v1(40)]-15-[v2(11)]-3-[v3(35)]-5-[v4(35)]", views: setNumberLabel, emailButton, numberLabel, numberTextField, resultLabel)
        
        //: Constraints for the continue button
        view.addConstraintsWithFormat(format: "H:|-68-[v0]-68-|", views: continueButton)
        view.addConstraintsWithFormat(format: "V:[v0(44)]", views: continueButton)
        bottomConstraint = NSLayoutConstraint(item: continueButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -(216 + 25))
        view.addConstraint(bottomConstraint!)
    }
    
    private func setUpAreaContainer() {
        //: Add a right border to the area Container
        let rightBorderView = UIView()
        rightBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        areaContainer.addSubview(rightBorderView)
        areaContainer.addSubview(areaCodeButton)
        
        //: Constraints for the rightBorderView & areaCodeButton
        areaContainer.addConstraintsWithFormat(format: "H:|[v0]-3.4-[v1(1.2)]-5-|", views: areaCodeButton, rightBorderView)
        areaContainer.addConstraintsWithFormat(format: "V:[v0(20)]", views: rightBorderView)
        areaContainer.addConstraint(NSLayoutConstraint(item: rightBorderView, attribute: .centerY, relatedBy: .equal, toItem: areaContainer, attribute: .centerY, multiplier: 1, constant: 5))
        areaContainer.addConstraint(NSLayoutConstraint(item: areaCodeButton, attribute: .centerY, relatedBy: .equal, toItem: areaContainer, attribute: .centerY, multiplier: 1, constant: 3.5))
    }
    
    //: MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        numberTextField.becomeFirstResponder()
        areaCodeButton.setTitle(PhoneController.areaCode, for: .normal)
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
