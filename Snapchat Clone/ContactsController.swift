//
//  ContactsController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/20/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit
import Contacts

class ContactsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let purpleButtonColor =  UIColor.rgb(red: 153, green: 87, blue: 159)
    static let cellId = "cellId"
    static let footerId = "footerId"
    var contacts = [CNContact]()
    
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
        cv.alwaysBounceVertical = true
        cv.register(ContactCell.self, forCellWithReuseIdentifier: ContactsController.cellId)
        cv.register(FooterCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: ContactsController.footerId)
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
        let message = "Snapchat clone is more fun with friends! Are you sure you want to skip this step?"
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            //self.dismiss(animated: true, completion: nil)
            //self.present(MainController(), animated: false, completion: nil)
            
            //: TODO: Change MainController to snapContainer
            /*self.present(MainController(), animated: false, completion: {
                self.navigationController?.viewControllers = []
            }) */
            UserDefaults.standard.setIsLoggedIn(value: true)
            UserDefaults.standard.setIsFirstLaunch(value: true)
            self.perform(#selector(self.showLoginController), with: nil, afterDelay: 0.01)
        }
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        noAction.setValue(purpleButtonColor, forKey: "titleTextColor")
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
    func continueButtonTapped() {
        print("continue button tapped!")
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
        return contacts.count
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
        let currentContact = contacts[indexPath.item]
        cell.fullName.text = currentContact.givenName + " " + currentContact.familyName
        //: Set the username's text with the contact's number if set, if not use their email as an alternative.
        let validNumber = (currentContact.phoneNumbers.first?.value)?.stringValue
        let email = (currentContact.emailAddresses.first?.value) as String?
        cell.username.text = validNumber ?? email
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
    //: MARK: Modifying the FooterCell
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ContactsController.footerId, for: indexPath) as! FooterCell
        //: Handle taps inside the footer cell
        let tap = UITapGestureRecognizer(target: self, action: #selector(footerTapped))
        footer.addGestureRecognizer(tap)
        return footer
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    func footerTapped() {
        let alert = UIAlertController(title: "Phone Verification Required", message: "To view more Snapchatters in your contacts, please verify your phone number.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAction.setValue(purpleButtonColor, forKey: "titleTextColor")
        let verifyAction = UIAlertAction(title: "Verify Now", style: .default) { (_) in
            PhoneController.isComingFromContacts = true
            self.navigationController?.pushViewController(PhoneController(), animated: false)
        }
        alert.addAction(cancelAction)
        alert.addAction(verifyAction)
        present(alert, animated: true, completion: nil)
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
        setupViews()
    }
    func setupViews() {
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
    //: MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    //: MARK: - viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
