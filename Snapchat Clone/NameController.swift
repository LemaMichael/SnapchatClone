//
//  SignUp.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/3/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit


class NameController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.red
        
        /*
         scrollView.clipsToBounds = true
         scrollView.isMultipleTouchEnabled = true
         scrollView.contentMode = .scaleAspectFill
         scrollView.bounces = true
         */
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Heavy", size: 22)
        label.text = "What's your name?"
        return label
    }()
    
    let firstNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 11)
        label.textColor = UIColor.lightGray
        label.text = "FIRST NAME"
        return label
    }()
    
    let firstNameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 11)
        label.textColor = UIColor.lightGray
        label.text = "LAST NAME"
        return label
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    let agreementTextField: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.font = UIFont(name: "Avenir-Medium", size: 11)
        //: Display links
        //textField.isSelectable = true
        //textField.dataDetectorTypes = UIDataDetectorTypes.all
        let attributedString = NSMutableAttributedString(string: "By tapping Sign Up & Accept, you agree to the Terms of Service and Privacy Policy")
        attributedString.addAttributes([NSLinkAttributeName : NSURL(string: "https://en.wikipedia.org/wiki/Terms_of_service" )!, NSForegroundColorAttributeName : UIColor.blue], range: NSMakeRange(10, 15))
        
        // textView.delegate = (self as! UITextViewDelegate)
        textView.attributedText = attributedString
        
        
        
        return textView
    }()
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return true
    }
    
    
    
    
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.white
        setUpNavigationBar()
        
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(questionLabel)
        scrollView.addSubview(firstNameLabel)
        scrollView.addSubview(firstNameTextField)
        scrollView.addSubview(lastNameLabel)
        scrollView.addSubview(lastNameTextField)
        scrollView.addSubview(agreementTextField)
        setUpViews()
        
        
    }
    
    //: MARK: - Set up Navigation Bar
    func setUpNavigationBar() {
        //: Change back button image in Navigation Bar
        let backButtonImage = UIImage(named: "BackButton")?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(pushToWelcomeScreen))
        
        //: Transparent UINavigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
    }
    
    //: Go back to WelcomeController
    func pushToWelcomeScreen() {
        navigationController?.popViewController(animated: false)
    }
    
    
    //: MARK: - Set up Views
    func setUpViews() {
        //view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        //view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
        
        
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: questionLabel)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]", views: firstNameLabel)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: firstNameTextField)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: lastNameLabel)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: lastNameTextField)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: agreementTextField)
        
        scrollView.addConstraintsWithFormat(format: "V:|-50-[v0]-20-[v1]-4-[v2(40)]-8-[v3]-4-[v4(40)]-20-[v5(25)]", views: questionLabel, firstNameLabel, firstNameTextField, lastNameLabel, lastNameTextField, agreementTextField)
        
        
        
    }
    
    
    //: Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
}
