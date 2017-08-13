//
//  BirthdayController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/8/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class BirthdayController : UIViewController, UIGestureRecognizerDelegate {
    
    private let purpleButtonColor =  UIColor.rgb(red: 153, green: 87, blue: 159)
    private let grayButtonColor = UIColor.rgb(red: 185, green: 192, blue: 199)
    //: Keep track of the date, 'Changing the variable for the static property changes the property in all future instances.
    static var currentState: Date!
    
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
        datePicker.addTarget(self, action: #selector(dataPickerChanged), for: .valueChanged)
        return datePicker
    }()
    //: MARK: UIDataPicker functions
    func dataPickerChanged(datePicker: UIDatePicker) {
        //: To display a date to a user, set the dateStyle and timeStyle properties of the date formatter
        let dateFormatter = DateFormatter()
        //: The following will show the month, day, and year without showing the time.
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let date = dateFormatter.string(from: datePicker.date)
        birthdayTextField.text = date
        continueButton.backgroundColor = purpleButtonColor
    }
    
    func detectDataPickerSwipe() {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(isScrolling))
        gestureRecognizer.direction = [.up, .down]
        gestureRecognizer.delegate = self
        datePicker.addGestureRecognizer(gestureRecognizer)
    }
    
    func isScrolling(gestureRecognizer: UISwipeGestureRecognizer) {
        //: If the data Picker is scrolling, change the button's color
        continueButton.backgroundColor = grayButtonColor
    }
    
    //: MARK: - Gesture Recognizer
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //: "returning True is guaranteed to allow simultaneous recognition." This is exactly what I need to detect a swipe inside datePicker
        return true
    }
    
    func continueButtonTapped() {
        print("Continue button tapped")
    }

    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        detectDataPickerSwipe()
        setUpNavigationBar()
        view.addSubview(questionLabel)
        view.addSubview(birthdayLabel)
        view.addSubview(birthdayTextField)
        view.addSubview(continueButton)
        view.addSubview(datePicker)
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (BirthdayController.currentState != nil) {
            datePicker.date = BirthdayController.currentState
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            let date = dateFormatter.string(from: datePicker.date)
            birthdayTextField.text = date
            continueButton.backgroundColor = purpleButtonColor
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //: If the textField's text is empty, that means the user has not selected a date yet.
        guard let text = birthdayTextField.text, !text.isEmpty else {
            return
        }
        BirthdayController.currentState = datePicker.date
    }
    
    //: MARK: - Set up Navigation Bar
    func setUpNavigationBar() {
        let backbuttonImage = UIImage(named: "BackButton")?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backbuttonImage, style: .plain, target: self, action: #selector(pushToNameController))
    }

    func pushToNameController() {
        //: Go back to NameController
        navigationController?.popViewController(animated: false)
    }
    
    //: MARK: - Set up views
    func setUpViews() {
        let space = UIScreen.main.bounds.height / 5
        view.addConstraintsWithFormat(format: "H:|-65-[v0]-65-|", views: questionLabel)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: birthdayLabel)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: birthdayTextField)
        view.addConstraintsWithFormat(format: "H:|-68-[v0]-68-|", views: continueButton)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: datePicker)

        view.addConstraintsWithFormat(format: "V:[v0(35)]-15-[v1(11)][v2(35)]-\(space)-[v3(44)]-25-[v4(216)]|", views: questionLabel, birthdayLabel, birthdayTextField, continueButton,datePicker)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
