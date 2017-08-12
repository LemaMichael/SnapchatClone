//
//  SignUp.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/3/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit

class NameController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    let purpleButtonColor =  UIColor.rgb(red: 153, green: 87, blue: 159)
    let grayButtonColor = UIColor.rgb(red: 185, green: 192, blue: 199)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.red
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = self
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
        label.font = UIFont(name: "Avenir-Medium", size: 19)
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
        //: Hide the suggestion list above keyboard
        textField.autocorrectionType = .no
        //: Change the reutn key type
        textField.returnKeyType = .next
        //: 'Will automatically disable return key when text has zero-length contents, and will automatically enable when text widget has non-zero-length contents'
        textField.enablesReturnKeyAutomatically = true
        textField.font = UIFont(name: "Avenir-Medium", size: 16)
        
        //: Set border Style to be underlined
        textField.setUnderlinedBorder()
        
        //: Set the tag so textFieldShouldReturn can determine the textField
        textField.tag = 0
        
        //: Detect text field changes
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
        //: Hide the suggestion list above keyboard
        textField.autocorrectionType = .no
        //: Change the return key type
        textField.returnKeyType = .next
        //: 'Will automatically disable return key when text has zero-length contents, and will automatically enable when text widget has non-zero-length contents'
        textField.enablesReturnKeyAutomatically = true
        textField.font = UIFont(name: "Avenir-Medium", size: 16)
        
        //: Set border Style to be underlined
        textField.setUnderlinedBorder()
        
        //: Set the tag so textFieldShouldReturn can determine the textField
        textField.tag = 1
        
        //: Detect text field changes
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
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
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Sign Up & Accept", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        button.backgroundColor = self.grayButtonColor
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

        //: Make the button round
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        return button
    }()
    
    var buttonYposition: CGFloat!
    var difference: CGFloat!
    
    //: MARK: - Sign Up button tapped
    func signUpButtonTapped() {
        //: If the sign up button color is not purple, do nothing, else we are good to go because there is at least one valid text in either text fields.
        if (signUpButton.backgroundColor != purpleButtonColor) {
            return
        } else {
            //: Snapchat goes back to the firstNameTextField when the user goes back from the new viewController (BirthdayController)
            firstNameTextField.becomeFirstResponder()
            navigationController?.pushViewController(BirthdayController(), animated: false)
        }
    }
    
    //: MARK: - Text Field methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //: This must be the firstNameTextField where the user tapped 'Next', therefore go the the lastNameTextField
        if textField.tag == 0 {
            firstNameTextField.resignFirstResponder()
            lastNameTextField.becomeFirstResponder()
        } else if textField.tag == 1 {
            //: If the user tapped 'Next' again, check if there is a valid text in either firstName or lastName Text fields.
            lastNameTextField.resignFirstResponder()
            
            //: If the sign up button color is purple, we are good to go because there is at least one valid text in either text fields.
            if signUpButton.backgroundColor == purpleButtonColor {
                //: Snapchat goes back to the firstNameTextField when the user goes back from the new viewController (BirthdayController)
                firstNameTextField.becomeFirstResponder()
                navigationController?.pushViewController(BirthdayController(), animated: false)
            } else {
                //: Both text fields are empty, therefore go to the firstNameTextField
                firstNameTextField.becomeFirstResponder()
            }
        }
        return false
    }
    
    //: TODO: Find a better way to do this.
    func textFieldDidChange(textField: UITextField) {
        
        //: If the text is valid, change the sign up button color
        if let validText = textField.text {
            //: Check if the text is not empty (including only white spaces)
            if !(validText.trimmingCharacters(in: .whitespaces).isEmpty) {
                //: If the purple background is already set, don't do anything
                if !(signUpButton.backgroundColor == purpleButtonColor) {
                    signUpButton.backgroundColor = purpleButtonColor
                }
            } else {
                //: If firstNameTextField is a valid text, but lastNameTextField is not, don't change the color
                
                //: If firstNameTextField is having its text changed, check if lastNameTextField has a valid text before changing to original color
                if textField.tag == 0 {
                    
                    if let lastNameValidText = lastNameTextField.text {
                        if !(lastNameValidText.trimmingCharacters(in: .whitespaces).isEmpty) {
                            //: Leave the button as is, since there is a valid text
                            return
                        } else {
                            //: Set the sign up button to its original color (dark gray) if it's not already set.
                            if !(signUpButton.backgroundColor == grayButtonColor) {
                                signUpButton.backgroundColor = grayButtonColor
                            }
                        }
                        
                    }
                }
                //: If lastNameTextField is a valid text, but firstNameTextField is not, don't change the color
                else if textField.tag == 1 {
                    
                    if let firstNameValidText = firstNameTextField.text {
                        if !(firstNameValidText.trimmingCharacters(in: .whitespaces).isEmpty) {
                            //: Leave the button as is, since there is a valid text
                            return
                        } else {
                            //: Set the sign up button to its original color (dark gray) if it's not already set.
                            if !(signUpButton.backgroundColor == grayButtonColor) {
                                signUpButton.backgroundColor = grayButtonColor
                            }
                        }
                    }
                }
            }
        }
    }
    
    //: MARK: - ScrollView DidScroll
    //: TODO: Fix the repetitive code or find a better way to do this.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset: CGFloat = -scrollView.contentOffset.y
        //print("The current offset is \(offset)")
        
        //: For iphone 5 or below
        if UIScreen.main.bounds.height < 667 {
            //: The added numbers after the difference is the height, which were written for the constraints
            let percentage: CGFloat = (offset) / (difference)
            agreementTextField.alpha = (1 - percentage)
            lastNameTextField.alpha = 1.0 - ((offset) / (difference + 45 + 50))
            lastNameLabel.alpha = 1.0 - ((offset) / (difference + 56 + 50))
            firstNameTextField.alpha = 1.0 - ((offset) / (difference + 105 + 50))
            firstNameLabel.alpha = 1.0 - ((offset) / (difference + 116 + 50))
            questionLabel.alpha = 1.0 - ((offset) / (difference + 130 + 50))
        } else {
            //: For iphone 6 and above
            let percentage: CGFloat = (offset) / (2 * difference)
            agreementTextField.alpha = (1 - percentage)
            lastNameTextField.alpha = 1.0 - ((offset) / (2 * difference + 45 + 50))
            lastNameLabel.alpha = 1.0 - ((offset) / (2 * difference + 56 + 50))
            firstNameTextField.alpha = 1.0 - ((offset) / (2 * difference + 105 + 50))
            firstNameLabel.alpha = 1.0 - ((offset) / (2 * difference + 116 + 50))
            questionLabel.alpha = 1.0 - ((offset) / (2 * difference + 130 + 50))
        }
    }
    
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        view.addSubview(signUpButton) //scrollView.superview?.addSubview(signUpButton)

        setUpViews()
        //: Set the delegate for each text field
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
    }
    
    
    //: MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //: This view will be added to the window using an animation.
        firstNameTextField.becomeFirstResponder()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //: Modify your UI before the view is presented to the screen - in this case determine the height for UI elements.
        buttonYposition = -signUpButton.frame.origin.y
        print("The y position for button: \(buttonYposition!)")
        let height = self.scrollView.frame.height
        print("The height of the contentView is: \(height)" )
        difference = height + buttonYposition
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
        
        
        contentView.addConstraintsWithFormat(format: "H:|-75-[v0]-75-|", views: questionLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: firstNameLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: firstNameTextField)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: lastNameLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: lastNameTextField)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: agreementTextField)
        
        //: 44 points seems to be the height of the navigation bar
        contentView.addConstraintsWithFormat(format: "V:|-44-[v0]-20-[v1(11)][v2(35)]-14-[v3(11)][v4(35)]-10-[v5(50)]", views: questionLabel, firstNameLabel, firstNameTextField, lastNameLabel, lastNameTextField, agreementTextField)
        
        //: Constraints for sign up button
        view.addConstraintsWithFormat(format: "H:|-68-[v0]-68-|", views: signUpButton)
        view.addConstraintsWithFormat(format: "V:[v0(44)]", views: signUpButton)
        
        //: 216 points is the height of the keyboard, 25 points is for spacing between the keyboard and the sign up button
        view.addConstraint(NSLayoutConstraint(item: signUpButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -(216 + 25)) )
    }
    
    //: Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
