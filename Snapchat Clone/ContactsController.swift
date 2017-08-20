//
//  ContactsController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/20/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class ContactsController: UIViewController {
    private let purpleButtonColor =  UIColor.rgb(red: 153, green: 87, blue: 159)
    
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
    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.red
        return cv
    }()
    
    //: MARK: - Button actions
    func skipTapped() {
        print("skip button tapped")
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
        
        view.addConstraintsWithFormat(format: "V:|-35-[v0(30)][v1(40)]-[v2(1)]-4-[v3][v4]|", views: addFriendsLabel, descriptionLabel, borderView, snapchattersLabel, collectionView)
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
    func setUpCell() {
        
    }
}
