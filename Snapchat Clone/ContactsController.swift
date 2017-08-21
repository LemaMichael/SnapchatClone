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
        cv.register(ContactCell.self, forCellWithReuseIdentifier: ContactsController.cellId)
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    //: MARK: - Button actions
    func skipTapped() {
        print("skip button tapped")
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
        return cell
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
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        label.textColor = UIColor.rgb(red: 22, green: 25, blue: 28)
        label.textAlignment = .left
        label.text = "Michael Lema"
        return label
    }()
    let username: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 11)
        label.textColor = UIColor.rgb(red: 189, green: 195, blue: 201)
        label.textAlignment = .left
        label.text = "mlmike1031"
        return label
    }()
    let addTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.isEnabled = false
        textField.isUserInteractionEnabled = false
        textField.font = UIFont(name: "Avenir-Heavy", size: 15)
        textField.textColor = UIColor.rgb(red: 140, green: 71, blue: 191)
        textField.text = "Add"
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftViewMode = UITextFieldViewMode.always
        return textField
    }()
    let addImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 7, height: 7))
        let image = UIImage(named: "Add Friend")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let addedImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 2, height: 2))
        let image = UIImage(named: "Added Friend")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        addTextField.leftView = addImageView
        addSubview(stackView)
        addSubview(addTextField)
        addSubview(borderView)
        
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -12))
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 12))
        
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 60))
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: addTextField, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: addTextField, attribute: .left, relatedBy: .equal, toItem: stackView, attribute: .right, multiplier: 1, constant: 0))
        
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: borderView)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: borderView)
    }
}
