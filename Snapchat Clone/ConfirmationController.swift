//
//  ConfirmationCodeController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/16/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class ConfirmationController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    private let purpleButtonColor =  UIColor.rgb(red: 153, green: 87, blue: 159)
    private let grayButtonColor = UIColor.rgb(red: 185, green: 192, blue: 199)
    private let faintRedColor = UIColor.rgb(red: 239, green: 63, blue: 90)
    private var bottomConstraint: NSLayoutConstraint?
    private var buttonyYposition: CGFloat!
    private var difference: CGFloat!
    static var phoneNumber: String?
    private var textFields = [UITextField]()
    private var tagNumber = 0
    private var hasTyped = false
    private var hasTappedCallButton = false

    var seconds = 60
    var timer = Timer()
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        if seconds > 0  {
            seconds -= 1
        } else {
            resendButton.backgroundColor = purpleButtonColor
            timer.invalidate()
            resendButton.setTitle("Resend", for: .normal)
            seconds = 60
        }
        if !hasTyped && seconds != 60 {
            resendButton.setTitle("Resend \(seconds)", for: .normal)
        }
    }
    
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
    
    let confirmationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Medium", size: 19)
        label.text = "Enter Confirmation Code"
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 14.3)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = "Enter the code we sent to "
        return label
    }()
    
    let callButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 12.3)
        let lightBlue = UIColor.rgb(red: 21, green: 126, blue: 251)
        button.setTitleColor(lightBlue, for: .normal)
        button.setTitle("Call me instead", for: .normal)
        button.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let codeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 11)
        label.textColor = .lightGray
        label.text = "CODE"
        return label
    }()
    
    lazy var firstTextField = self.createTextField()
    lazy var secondTextField = self.createTextField()
    lazy var thirdTextField = self.createTextField()
    lazy var fourthTextField = self.createTextField()
    lazy var fifthTextField = self.createTextField()
    lazy var sixthTextField = self.createTextField()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: self.textFields)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()

    lazy var resendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Resend 60", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        button.backgroundColor = self.grayButtonColor
        button.addTarget(self, action: #selector(resendButtonTapped), for: .touchUpInside)
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
        label.textColor = UIColor.rgb(red: 239, green: 63, blue: 90)
        label.text = "That's not the right code!"
        label.isHidden = true
        return label
    }()
    //: MARK: This function will create 6 text fields
    func createTextField() -> UITextField {
        tagNumber += 1
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.font = UIFont(name: "Avenir-Medium", size: 22)
        textField.textAlignment = .center
        textField.setUnderlinedBorder()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.delegate = self
        textField.tag = tagNumber
        return textField
    }
    
    //: MARK: - Button Actions
    func resendButtonTapped() {
        guard let text = resendButton.titleLabel?.text, resendButton.backgroundColor == purpleButtonColor else {
            //: Don't do anything if the resendButton is a grayButtonColor
            return
        }
        if text == "Continue" &&  resendButton.backgroundColor == grayButtonColor  {
            return
        }
        resultLabel.isHidden = false
        if !timer.isValid {
            resendButton.backgroundColor = grayButtonColor
            runTimer()
        }
    }
    
    func callButtonTapped() {
        //: This will display an alert, that's all
        guard let number = ConfirmationController.phoneNumber else {
            return
        }
        if !hasTappedCallButton {
            let message = "We'll call you at " + number + "."
            let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Okay", style: .default, handler: { (_) in
                //: Change the button message
                self.callButton.setTitle("Send code via SMS", for: .normal)
                self.hasTappedCallButton = true
            })
            let cancelAcetion = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            cancelAcetion.setValue(purpleButtonColor, forKey: "titleTextColor")
            alert.addAction(cancelAcetion)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
           
        } else {
            //: If we are here, the call button has already been tapped
            let message = "We'll send you an SMS code at " + number + "."
            let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            //let defaultAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            let defaultAction = UIAlertAction(title: "Okay", style: .default, handler: { (_) in
                self.callButton.setTitle("Call me instead", for: .normal)
                self.hasTappedCallButton = false
            })
            let cancelAcetion = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            cancelAcetion.setValue(purpleButtonColor, forKey: "titleTextColor")
            alert.addAction(cancelAcetion)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
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
                stackView.alpha = 1.0 - ((offset) / (difference + 45 + 50))
                codeLabel.alpha = 1.0 - ((offset) / (difference + 56 + 50))
                callButton.alpha = 1.0 - ((offset) / (difference + 105 + 50))
                confirmationLabel.alpha = 1.0 - ((offset) / (difference + 116 + 50))
            } else {
                //: For iphone 6 and above
                let percentage: CGFloat = (offset) / (2 * difference)
                resultLabel.alpha = (1 - percentage)
                stackView.alpha = 1.0 - ((offset) / (2 * difference + 45 + 50))
                codeLabel.alpha = 1.0 - ((offset) / (2 * difference + 56 + 50))
                callButton.alpha = 1.0 - ((offset) / (2 * difference + 105 + 50))
                confirmationLabel.alpha = 1.0 - ((offset) / (2 * difference + 116 + 50))
            }
        }
    }
    
    //: FIXME: There has to be a better way to do this
    //: MARK: - Text Field methods
    func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else {
            //resendButton.backgroundColor = grayButtonColor
            return
        }
        guard let currentText = resendButton.titleLabel?.text else {
            return
        }
        resultLabel.isHidden = true

        if text.utf16.count == 1 {
            switch textField {
            case firstTextField:
                hasTyped = true
                if currentText != "Resend" {
                    resendButton.setTitle("Continue", for: .normal)
                    resendButton.backgroundColor = grayButtonColor
                }
                secondTextField.becomeFirstResponder()
            case secondTextField:
                thirdTextField.becomeFirstResponder()
            case thirdTextField:
                fourthTextField.becomeFirstResponder()
            case fourthTextField:
                fifthTextField.becomeFirstResponder()
            case fifthTextField:
                sixthTextField.becomeFirstResponder()
            case sixthTextField:
                if currentText == "Resend" {
                    resendButton.setTitle("Continue", for: .normal)
                }
                resendButton.backgroundColor = purpleButtonColor
                sixthTextField.resignFirstResponder()
            default:
                break
            }
        }
        
        if text.utf16.count == 0 {
            switch textField {
            case firstTextField:
                //: This must mean all other textFields are empty
                //hasTyped = false
                hasTyped = resendButton.backgroundColor == grayButtonColor ? false : true
            case secondTextField:
                firstTextField.becomeFirstResponder()
                    resendButton.backgroundColor = grayButtonColor
            case thirdTextField:
                secondTextField.becomeFirstResponder()
                    resendButton.backgroundColor = grayButtonColor
            case fourthTextField:
                thirdTextField.becomeFirstResponder()
                    resendButton.backgroundColor = grayButtonColor
            case fifthTextField:
                fourthTextField.becomeFirstResponder()
                    resendButton.backgroundColor = grayButtonColor
            case sixthTextField:
                fifthTextField.becomeFirstResponder()
                resendButton.backgroundColor = grayButtonColor
            default:
                break
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return false
        }
        let validSet = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        let futureText = text + string
        //: TextField can only habe 1 character and it must be a digit.
        guard  futureText.utf16.count <= 1 && validSet.isSuperset(of: characterSet) else {
            //: Don't change anything
            return false
        }
        return true
    }
    
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        //: Display the back bar button item
        setUpNavigationBar(leftImage: "BackButton")
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.automaticallyAdjustsScrollViewInsets = false

        textFields.append(firstTextField)
        textFields.append(secondTextField)
        textFields.append(thirdTextField)
        textFields.append(fourthTextField)
        textFields.append(fifthTextField)
        textFields.append(sixthTextField)
        contentView.addSubview(confirmationLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(callButton)
        contentView.addSubview(codeLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(resultLabel)
        view.addSubview(resendButton)
        
        setUpViews()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillHide, object: nil)
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
        
        contentView.addConstraintsWithFormat(format: "H:|-75-[v0]-75-|", views: confirmationLabel)
        contentView.addConstraintsWithFormat(format: "H:|-90-[v0]-90-|", views: descriptionLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: callButton)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: codeLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: stackView)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: resultLabel)
        
        contentView.addConstraintsWithFormat(format: "V:|-\(screenCenter)-[v0(30)]-5-[v1(45)]-15-[v2(11)]-12-[v3(25)]-5-[v4(35)]-5-[v5(35)]", views: confirmationLabel, descriptionLabel, callButton, codeLabel, stackView, resultLabel)
        
        //: Constraints for the resend button
        view.addConstraintsWithFormat(format: "H:|-68-[v0]-68-|", views: resendButton)
        view.addConstraintsWithFormat(format: "V:[v0(44)]", views: resendButton)
        bottomConstraint = NSLayoutConstraint(item: resendButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -(216 + 25))
        view.addConstraint(bottomConstraint!)
    }
    
    //: MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        runTimer()
        firstTextField.becomeFirstResponder()
        guard let text = ConfirmationController.phoneNumber else {
            return
        }
        descriptionLabel.text! += text
    }
    //: MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        buttonyYposition = -resendButton.frame.origin.y
        let height = self.scrollView.frame.height
        difference = height + buttonyYposition
    }
    
    //: MARK: - Handle Keyboard Notification
    func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect
            let isKeyboardShowing = notification.name == .UIKeyboardWillChangeFrame
            bottomConstraint?.constant = isKeyboardShowing ? -(keyboardFrame!.height + 25) : -25
            
        }
    }
    //: Hide the status Bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
