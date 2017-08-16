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
    private let faintRedColor = UIColor.rgb(red: 239, green: 63, blue: 90)
    private let validList = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_."
    private let invalidCharacterSet = CharacterSet(charactersIn: " []{}#%^*+=\\|~<>€£¥•,?!'@&$)(;:/\"")
    private lazy var characterSet = CharacterSet()
    
    private var viewsWereSet = false
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
        label.font = UIFont(name: "Avenir-Medium", size: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
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
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.enablesReturnKeyAutomatically = true
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.font = UIFont(name: "Avenir-Medium", size: 16)
        textField.setUnderlinedBorder()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.rightViewMode = UITextFieldViewMode.whileEditing
        textField.delegate = self
        return textField
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Medium", size: 12)
        return label
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let image = UIImage(named: "Refresh")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
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
    
    //: FIXME: - Refresh Button action (find a better way to do this)
    func refreshTapped() {
        var count = 0
        guard let text = usernameTextField.text else {
            return
        }
        
        var isLessthan3 = isLessThan3Char(text: text)
        var isFirstCharNumber = isFirstCharANumber(text: text)
        var containsSpecialChar = containsInvalidChar(text: text)
        var isOver15Char = isOver15Character(text: text)
        print("-----------------------------")
        print("isLessthan3: \(isLessthan3)\nisFirstCharNumber:\(isFirstCharNumber)\ncontainsSpecialChar:\(containsSpecialChar)\nisOver15Char:\(isOver15Char)")
        var currentText = text

        while isLessthan3 || isFirstCharNumber || containsSpecialChar || isOver15Char {
            count += 1
            print("The currentText is: \(currentText)")
            print(count)
            
            if containsSpecialChar {
                print("I am inside containsSpecialChar")
                let components = text.components(separatedBy: invalidCharacterSet)
                let newText = components.joined(separator: "")
                print("The new text without spec. is \(newText)")
                currentText = newText
                isLessthan3 = isLessThan3Char(text: currentText)
                isFirstCharNumber = isFirstCharANumber(text: currentText)
                isOver15Char = isOver15Character(text: currentText)
                containsSpecialChar = false
            }
            
            if isFirstCharNumber {
                print("I am inside isFirstCharNumber")
                let newText = currentText.replacingCharacters(in: currentText.startIndex..<currentText.index(after: currentText.startIndex), with: newString())
                print("The first char is now \(newText)")
                currentText = newText
                isLessthan3 = isLessThan3Char(text: currentText)
                isFirstCharNumber = isFirstCharANumber(text: currentText)
                isOver15Char = isOver15Character(text: currentText)
            }
            
            if isLessthan3 {
                let previous = currentText
                print("I am inside isLessthan3")
                let currentCharCount = currentText.trimmingCharacters(in: .whitespaces).characters.count
                print("currentCharCount is \(currentCharCount)")
                for _ in currentCharCount..<3 {
                    currentText += newString()
                }
                print("The new text is \(currentText)")
                isLessthan3 = false

                if previous == currentText {
                    print("I shouldn't be here!")
                    currentText = ""
                    isLessthan3 = true
                    //isFirstCharNumber = isFirstCharANumber(text: currentText)
                }
                isFirstCharNumber = isFirstCharANumber(text: currentText)
                isOver15Char = isOver15Character(text: currentText)
            }
            if isOver15Char {
                print("I am inside isOver15Char")
                let index = currentText.index(currentText.startIndex, offsetBy: 15)
                currentText = currentText.substring(to: index)
                print("Current text has shortened to: \(currentText)")
                isLessthan3 = isLessThan3Char(text: currentText)
                isFirstCharNumber = isFirstCharANumber(text: currentText)
                isOver15Char = false
                //isOver15Char = isOver15Character(text: currentText)
                //containsSpecialChar = containsInvalidChar(text: currentText)
            }
        }
        print("the final value is now \(currentText)")
        usernameTextField.text = nil
        usernameTextField.insertText(currentText)
    }
    //: MARK: - Functions to determine valid username
    func isLessThan3Char(text: String) -> Bool {
        return text.trimmingCharacters(in: .whitespaces).characters.count < 3
    }
    func isFirstCharANumber(text: String) -> Bool {
        //: Will return true if first char is an int.
        if let firstChar = text.characters.first {
            return Int(String(describing: firstChar)) != nil
        }
        return false
    }
    func containsInvalidChar(text: String) -> Bool {
        //: Will return true if string has
        return text.rangeOfCharacter(from: characterSet.inverted) != nil
    }
    func isOver15Character(text: String) -> Bool {
        return text.characters.count > 15
    }
    
    func newString() -> String {
        var newString = ""
        let randomVal = arc4random_uniform(UInt32(validList.characters.count))
        newString  += "\(validList[validList.index(validList.startIndex, offsetBy: Int(randomVal))])"
        return newString
    }
    
    //: MARK: - Text Field methods
    func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        if !text.isEmpty {
            refreshButton.isHidden = false
            let firstLetter = text.characters.first!
            let isNumber = Int(String(describing: firstLetter))
            
            if text.trimmingCharacters(in: .whitespaces).characters.count < 3 {
                if text.rangeOfCharacter(from: invalidCharacterSet) == nil  && text.rangeOfCharacter(from: characterSet) == nil  {
                    refreshButton.isHidden = true
                    resultLabel.text = "Oops! Usernames can include letters, numbers, and one of -, _, or . 👌"
                    resultLabel.textColor = faintRedColor
                    continueButton.backgroundColor = grayButtonColor
                } else {
                    resultLabel.text = "Oops! Usernames must be at least 3 characters 📝"
                    resultLabel.textColor = faintRedColor
                    refreshButton.isHidden = false
                    continueButton.backgroundColor = grayButtonColor
                }
            } else if text.trimmingCharacters(in: .whitespaces).characters.count < 3 {
                //: Username cannot be less than 3 characters
                resultLabel.text = "Oops! Usernames must be at least 3 characters 📝"
                resultLabel.textColor = faintRedColor
                refreshButton.isHidden = false
                continueButton.backgroundColor = grayButtonColor
            } else if (isNumber != nil) {
                //: Username cannot start with a number
                resultLabel.text = "Oops! Usernames must start with a letter 🔠"
                resultLabel.textColor = faintRedColor
                continueButton.backgroundColor = grayButtonColor
            } else if text.rangeOfCharacter(from: characterSet.inverted) != nil {
                refreshButton.isHidden = true
                if text.rangeOfCharacter(from: invalidCharacterSet) != nil {
                    refreshButton.isHidden = false
                }
                //: Check if text contains special characters. When you invert a character set you get a new set that has every character except those from the original set.
                resultLabel.text = "Oops! Usernames can include letters, numbers, and one of -, _, or . 👌"
                resultLabel.textColor = faintRedColor
                continueButton.backgroundColor = grayButtonColor
            } else if text.characters.count > 15 {
                refreshButton.isHidden = false
                resultLabel.text = "Oops! Usernames cannot be longer than 15 characters 📖"
                resultLabel.textColor = faintRedColor
                continueButton.backgroundColor = grayButtonColor
            } else {
                //: Username is valid or check if it's available here
                resultLabel.text = "Username available"
                continueButton.backgroundColor = purpleButtonColor
                resultLabel.textColor = UIColor.rgb(red: 206, green: 212, blue: 218)
            }
        } else {
            //: Text is empty
            refreshButton.isHidden = true
            resultLabel.text = nil
            continueButton.backgroundColor = grayButtonColor
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //: This is similiar to when continue button is tapped
        if continueButton.backgroundColor != purpleButtonColor {
            return false
        }
        self.navigationController?.pushViewController(PasswordController(), animated: false)
        PasswordController.username = textField.text
        return true
    }
    
    //: MARK: - Handle continue button
    func continueButtonTapped() {
        if continueButton.backgroundColor != purpleButtonColor {
            return
        }
        //: The user has a valid username and is ready to setup password
        self.navigationController?.pushViewController(PasswordController(), animated: false)
        PasswordController.username = usernameTextField.text

    }
    
    //: MARK: - scrollViewDidScroll
    //: FIXME: Find a better way to do this
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset: CGFloat = -scrollView.contentOffset.y
        //: ViewsWereSet must be true before fading views
        if (difference != nil) && viewsWereSet {
            //: For iphone 5 or below
            if UIScreen.main.bounds.height < 667 {
                //: The added numbers after the difference is the height, which were written for the constraints
                let percentage: CGFloat = (offset) / (difference)
                resultLabel.alpha = (1 - percentage)
                usernameTextField.alpha = 1.0 - ((offset) / (difference + 45 + 50))
                usernamelabel.alpha = 1.0 - ((offset) / (difference + 56 + 50))
                descriptionLabel.alpha = 1.0 - ((offset) / (difference + 105 + 50))
                pickUsernameLabel.alpha = 1.0 - ((offset) / (difference + 116 + 50))
            } else {
                //: For iphone 6 and above
                let percentage: CGFloat = (offset) / (2 * difference)
                resultLabel.alpha = (1 - percentage)
                usernameTextField.alpha = 1.0 - ((offset) / (2 * difference + 45 + 50))
                usernamelabel.alpha = 1.0 - ((offset) / (2 * difference + 56 + 50))
                descriptionLabel.alpha = 1.0 - ((offset) / (2 * difference + 105 + 50))
                pickUsernameLabel.alpha = 1.0 - ((offset) / (2 * difference + 116 + 50))
            }
        }
    }

    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //: Set up valid characters. This will be used to check if username is valid
        characterSet = CharacterSet(charactersIn: validList)

        view.backgroundColor = .white
        setUpNavigationBar(leftImage: "BackButton")
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.automaticallyAdjustsScrollViewInsets = false
        
        contentView.addSubview(pickUsernameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(usernamelabel)
        contentView.addSubview(usernameTextField)
        contentView.addSubview(resultLabel)
        view.addSubview(continueButton)
        
        setUpViews()
        //: Add a button to the right side of text field.
        usernameTextField.rightView = refreshButton
        
        //: Implement a listener for when the keyboard will show up
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    //: MARK: - Adjust views
    func setUpViews() {
        let screenCenter = UIScreen.main.bounds.height / 3.5
        //: ScrollView & contentView constraints
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: contentView)
        scrollView.addConstraintsWithFormat(format: "V:|[v0]|", views: contentView)
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0))
        
        contentView.addConstraintsWithFormat(format: "H:|-75-[v0]-75-|", views: pickUsernameLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: descriptionLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: usernamelabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: usernameTextField)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: resultLabel)
        
        contentView.addConstraintsWithFormat(format: "V:|-\(screenCenter)-[v0(30)][v1(40)]-15-[v2(11)]-3-[v3(35)]-5-[v4(35)]", views: pickUsernameLabel, descriptionLabel, usernamelabel, usernameTextField, resultLabel)
        
        view.addConstraintsWithFormat(format: "H:|-68-[v0]-68-|", views: continueButton)
        view.addConstraintsWithFormat(format: "V:[v0(44)]", views: continueButton)
        bottomConstraint = NSLayoutConstraint(item: continueButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -25)
        view.addConstraint(bottomConstraint!)
    }
    
    //: FIXME: Not removing userNameTextField gives no errors, why?
    fileprivate func reapplyViews() {
        let screenCenter = UIScreen.main.bounds.height / 8
        //: Not sure why not removing userNameTextField gives no errors
        pickUsernameLabel.removeFromSuperview()
        descriptionLabel.removeFromSuperview()
        usernamelabel.removeFromSuperview()
        //usernameTextField.removeFromSuperview()
        resultLabel.removeFromSuperview()
        contentView.addSubview(pickUsernameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(usernamelabel)
        //contentView.addSubview(usernameTextField)
        contentView.addSubview(resultLabel)
        contentView.addConstraintsWithFormat(format: "H:|-75-[v0]-75-|", views: pickUsernameLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: descriptionLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: usernamelabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: usernameTextField)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: resultLabel)
        
        contentView.addConstraintsWithFormat(format: "V:|-\(screenCenter)-[v0(30)][v1(40)]-15-[v2(11)]-3-[v3(35)]-5-[v4(35)]", views: pickUsernameLabel, descriptionLabel, usernamelabel, usernameTextField, resultLabel)
    }
    
    //: MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonyYposition = -continueButton.frame.origin.y
        let height = self.scrollView.frame.height
        difference = height + buttonyYposition
    }
    
    
    //: MARK: - Handle Keyboard Notification
    func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect
            bottomConstraint?.constant = -(keyboardFrame!.height + 25)
            
            //: Reapplying the views should only be called once!
            if !viewsWereSet {
                reapplyViews()
                viewsWereSet = true
            }
        }
    }
   
    //: Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
