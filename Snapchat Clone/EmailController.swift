//
//  EmailController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/15/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class EmailController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    private let purpleButtonColor =  UIColor.rgb(red: 153, green: 87, blue: 159)
    private let grayButtonColor = UIColor.rgb(red: 185, green: 192, blue: 199)
    private var bottomConstraint: NSLayoutConstraint?
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
    
    let setEmailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 19)
        label.text = "What's your email?"
        return label
    }()
    
    let phoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 11.5)
        let lightBlue = UIColor.rgb(red: 21, green: 126, blue: 251)
        button.setTitleColor(lightBlue, for: .normal)
        button.setTitle("Sign up with phone instead", for: .normal)
        button.addTarget(self, action: #selector(phoneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 11)
        label.textColor = .lightGray
        label.text = "EMAIL"
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.keyboardType = .emailAddress
        textField.enablesReturnKeyAutomatically = true
        textField.font = UIFont(name: "Avenir-Medium", size: 16)
        textField.setUnderlinedBorder()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Medium", size: 12)
        //: Faint red color
        label.textColor = UIColor.rgb(red: 239, green: 63, blue: 90)
        label.text = "Please enter a valid email address."
        label.isHidden = true
        return label
    }()
    //: MARK: - Button Actions
    func continueButtonTapped() {
        guard let text = emailTextField.text, !text.isEmpty, isValidEmail(email: text) else {
            resultLabel.isHidden = false
            return
        }
        //: If we are here then the email is valid
        self.navigationController?.pushViewController(PhoneController(), animated: false)
    }
    func phoneButtonTapped() {
        print("Phone button tapped")
        self.navigationController?.pushViewController(PhoneController(), animated: false)
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
                emailTextField.alpha = 1.0 - ((offset) / (difference + 45 + 50))
                emailLabel.alpha = 1.0 - ((offset) / (difference + 56 + 50))
                phoneButton.alpha = 1.0 - ((offset) / (difference + 105 + 50))
                setEmailLabel.alpha = 1.0 - ((offset) / (difference + 116 + 50))
            } else {
                //: For iphone 6 and above
                let percentage: CGFloat = (offset) / (2 * difference)
                resultLabel.alpha = (1 - percentage)
                emailTextField.alpha = 1.0 - ((offset) / (2 * difference + 45 + 50))
                emailLabel.alpha = 1.0 - ((offset) / (2 * difference + 56 + 50))
                phoneButton.alpha = 1.0 - ((offset) / (2 * difference + 105 + 50))
                setEmailLabel.alpha = 1.0 - ((offset) / (2 * difference + 116 + 50))
            }
        }
    }
    
    //: MARK: - Text Field methods
    func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            resultLabel.isHidden = true
            continueButton.backgroundColor = grayButtonColor
            return
        }
        resultLabel.isHidden = true
        continueButton.backgroundColor = purpleButtonColor
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, isValidEmail(email: text) else {
            resultLabel.isHidden = false
            return false
        }
        //: If we are here that means the email is valid
        self.navigationController?.pushViewController(PhoneController(), animated: false)
        return true
    }
    
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //self.navigationController?.viewControllers.remove(at: 0)
        /*
         var viewControllers = navigationController?.viewControllers
         viewControllers?.removeFirst(2) //here 2 views to pop index numbers of views
         navigationController?.setViewControllers(viewControllers!, animated: true)
         */
        //: Hide the back bar button item
        setUpNavigationBar(leftImage: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.automaticallyAdjustsScrollViewInsets = false
        
        contentView.addSubview(setEmailLabel)
        contentView.addSubview(phoneButton)
        contentView.addSubview(emailLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(resultLabel)
        view.addSubview(continueButton)
        
        setUpViews()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillChangeFrame, object: nil)
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
        
        contentView.addConstraintsWithFormat(format: "H:|-75-[v0]-75-|", views: setEmailLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: phoneButton)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: emailLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: emailTextField)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: resultLabel)
        
        contentView.addConstraintsWithFormat(format: "V:|-\(screenCenter)-[v0(30)][v1(40)]-15-[v2(11)]-3-[v3(35)]-5-[v4(35)]", views: setEmailLabel, phoneButton, emailLabel, emailTextField, resultLabel)
        
        //: Constraints for the continue button
        view.addConstraintsWithFormat(format: "H:|-68-[v0]-68-|", views: continueButton)
        view.addConstraintsWithFormat(format: "V:[v0(44)]", views: continueButton)
        bottomConstraint = NSLayoutConstraint(item: continueButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -(216 + 25))
        view.addConstraint(bottomConstraint!)
    }
    
    //: MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.becomeFirstResponder()
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
