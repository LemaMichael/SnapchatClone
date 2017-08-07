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
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    //: This view will contain the labels & textfields
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 21)
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
        textField.font = UIFont(name: "Avenir-Medium", size: 16)

        //: Set border Style to be underlined
        textField.setUnderlinedBorder()
        
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
        textField.font = UIFont(name: "Avenir-Medium", size: 16)
        
        //: Set border Style to be underlined
        textField.setUnderlinedBorder()
        return textField
    }()
    
    let agreementTextField: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.isScrollEnabled = false
        textView.isEditable = false
       
        
        let attributedString = NSMutableAttributedString(string: "By tapping Sign Up & Accept, you agree to the Terms of Service and Privacy Policy.")
        
        //: 'Terms of Service' and 'Privacy Policy' are hyperlink texts
        attributedString.addAttribute(NSLinkAttributeName, value: "https://en.wikipedia.org/wiki/Terms_of_service", range: NSRange(location: 46, length: 16))
        attributedString.addAttribute(NSLinkAttributeName, value: "https://en.wikipedia.org/wiki/Privacy_policy", range: NSRange(location: 66, length: 15))
        textView.attributedText = attributedString
        //: The default font for NSAttributedString objects is Helvetica 12-point, therefore change it
        textView.font = UIFont(name: "Avenir-Medium", size: 11)

   
        return textView
    }()
    
    

    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.white
        setUpNavigationBar()
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //: The view controller should not automatically adjust its scroll view insets or there will be a mismatch in the content view positioning
        self.automaticallyAdjustsScrollViewInsets = false
        
        contentView.addSubview(questionLabel)
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(firstNameTextField)
        contentView.addSubview(lastNameLabel)
        contentView.addSubview(lastNameTextField)
        contentView.addSubview(agreementTextField)
        setUpViews()
        
        //: Needed to call textView(_ textView: shouldInteractWith URL:)
        agreementTextField.delegate = self

     
    }
    
    
    //: MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //: This view will be added to the window using an animation.
        firstNameTextField.becomeFirstResponder()
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
        
        //: Using scroll view with auto layout in 3 steps
        //: 1 - Set the scroll view constraints
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        
        //: 2- Set the content view (a subview of scroll view) constraints
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: contentView)
        scrollView.addConstraintsWithFormat(format: "V:|[v0]|", views: contentView)
        
        //: 3- Set equal width and equal height for the content view (without this, Layout issue: 'Scrollable content size is ambiguous for UIScrollView.')
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0))

        
        
        contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: questionLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: firstNameLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: firstNameTextField)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: lastNameLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: lastNameTextField)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: agreementTextField)
        
        //: 44 points seems to be the height of the navigation bar
        contentView.addConstraintsWithFormat(format: "V:|-44-[v0]-20-[v1(11)][v2(35)]-14-[v3(11)][v4(35)]-10-[v5(50)]", views: questionLabel, firstNameLabel, firstNameTextField, lastNameLabel, lastNameTextField, agreementTextField)
        
    
        
    }
    
    
    //: Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
}
