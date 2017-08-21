//
//  ContactsController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/20/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class ContactsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let purpleButtonColor =  UIColor.rgb(red: 153, green: 87, blue: 159)
    static let cellId = "cellId"
    
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 15)
        button.setTitleColor(UIColor.rgb(red: 206, green: 212, blue: 218), for: .normal)
        button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        return button
    }()
    let addFriendsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.rgb(red: 44, green: 49, blue: 55)
        label.font = UIFont(name: "Avenir-Medium", size: 19)
        label.text = "Add Friends"
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 14)
        label.textColor =  UIColor.rgb(red: 78, green: 86, blue: 95)
        label.numberOfLines = 0
        label.text = "Add your friends to send Snaps and view their stories!"
        return label
    }()
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 234, green: 237, blue: 239)
        return view
    }()
    lazy var snapchattersLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 12)
        label.textColor = self.purpleButtonColor
        label.text = "SNAPCHATTERS IN MY CONTACTS"
        return label
    }()
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.white
        cv.delegate = self
        cv.dataSource = self
        cv.allowsMultipleSelection = true
        cv.register(ContactCell.self, forCellWithReuseIdentifier: ContactsController.cellId)
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        button.backgroundColor = self.purpleButtonColor
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        //: Make button round
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.isHidden = true
        return button
    }()
    
    //: MARK: - Button actions
    func skipTapped() {
        print("skip button tapped")
    }
    func continueButtonTapped() {
        print("continuue button tapped!")
    }
    
    //: MARK: - Functions for modifying the ContactCell
    fileprivate func cellSelected(_ cell: ContactCell) {
        cell.addTextField.text = "Added"
        cell.addTextField.modifyLeftImage(UIImage(named: "Added Friend")!.withRenderingMode(.alwaysTemplate), padding: 8)
        cell.addTextField.backgroundColor = UIColor.rgb(red: 140, green: 71, blue: 191)
        cell.addTextField.layer.borderColor = UIColor.rgb(red: 140, green: 71, blue: 191).cgColor
        cell.addTextField.textColor = UIColor.white
    }
    fileprivate func cellUnselected(_ cell: ContactCell) {
        cell.addTextField.text = "Add"
        cell.addTextField.setLeftImage(UIImage(named: "Add Friend")!, padding: 17)
        cell.addTextField.backgroundColor = .clear
        cell.addTextField.layer.borderColor = UIColor.rgb(red: 227, green: 208, blue: 239).cgColor
        cell.addTextField.textColor = UIColor.rgb(red: 140, green: 71, blue: 191)
    }
    
    //: MARK: - Collection View functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactsController.cellId, for: indexPath) as! ContactCell
        //: Added this because reused (recycled) cells were showing the incorrect labels and images
        if cell.isSelected {
            cellSelected(cell)
        } else {
            cellUnselected(cell)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems else { return }
        if selectedIndexPaths.count == 1 {
            skipButton.isHidden = true
            continueButton.isHidden = false
        }
        let cell = collectionView.cellForItem(at: indexPath) as! ContactCell
        cellSelected(cell)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems else { return }
        if selectedIndexPaths.count == 0 {
            skipButton.isHidden = false
            continueButton.isHidden = true
        }
        let cell = collectionView.cellForItem(at: indexPath) as! ContactCell
        cellUnselected(cell)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
    }
    
    //: MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(skipButton)
        view.addSubview(addFriendsLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(borderView)
        view.addSubview(snapchattersLabel)
        view.addSubview(collectionView)
        view.addSubview(continueButton)
        setUpViews()
    }
    func setUpViews() {
        view.addConstraintsWithFormat(format: "H:[v0]-16-|", views: skipButton)
        view.addConstraintsWithFormat(format: "V:|-12-[v0]", views: skipButton)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: addFriendsLabel)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: descriptionLabel)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: borderView)
        view.addConstraintsWithFormat(format: "H:|-12-[v0]", views: snapchattersLabel)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        
        view.addConstraintsWithFormat(format: "V:|-35-[v0(30)][v1(40)]-[v2(1)]-4-[v3]-5-[v4]|", views: addFriendsLabel, descriptionLabel, borderView, snapchattersLabel, collectionView)
        
        view.addConstraintsWithFormat(format: "H:|-68-[v0]-68-|", views: continueButton)
        view.addConstraintsWithFormat(format: "V:[v0(44)]-25-|", views: continueButton)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

class ContactCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let fullName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 15)
        label.textColor = UIColor.rgb(red: 22, green: 25, blue: 28)
        label.textAlignment = .left
        label.text = "John Appleseed"
        return label
    }()
    let username: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 11)
        label.textColor = UIColor.rgb(red: 189, green: 195, blue: 201)
        label.textAlignment = .left
        label.text = "AppleseedJohn"
        return label
    }()
    let addTextField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        textField.isUserInteractionEnabled = false
        textField.layer.masksToBounds = true
        //: Making my own border
        textField.layer.cornerRadius = 14
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.rgb(red: 227, green: 208, blue: 239).cgColor
        textField.font = UIFont(name: "Avenir-Heavy", size: 13)
        textField.textColor = UIColor.rgb(red: 140, green: 71, blue: 191)
        textField.textAlignment = .center
        textField.text = "Add"
        //textField.adjustsFontSizeToFitWidth = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.fullName, self.username])
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 234, green: 237, blue: 239)
        return view
    }()
    
    func setUpCell() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addTextField.setLeftImage(UIImage(named: "Add Friend")!, padding: 17)
        addSubview(stackView)
        addSubview(addTextField)
        addSubview(borderView)
        //: Centering the Y position for the stackView and addTextField
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        //: Setting the left and right NSLayoutAttribute for the addTextField and stackView
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -12))
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 12))
        //: Setting the addTextField width and height constratins
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 75))
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        //: Setting the left and right NSLayoutAttribute for the addTextField and stackView
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: addTextField, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .left, relatedBy: .equal, toItem: stackView, attribute: .right, multiplier: 1, constant: 0))
        //: Setting the width & height constraints for the border
        addConstraintsWithFormat(format: "H:|[v0]|", views: borderView)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: borderView)
    }
}
