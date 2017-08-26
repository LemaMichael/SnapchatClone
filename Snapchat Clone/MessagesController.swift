//
//  MessagesController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/22/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class MessagesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let cellId = "cellId"
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        return container
    }()
    let mojiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Emoji")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        let searchImage = UIImage(named: "Search")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = UIColor.white
        button.setImage(searchImage, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        button.setTitle(" Chat", for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
        return button
    }()
    let newChatButton: UIButton = {
        let button = UIButton(type: .system)
        let searchImage = UIImage(named: "New Chat")?.withRenderingMode(.alwaysOriginal)
        button.setImage(searchImage, for: .normal)
        button.addTarget(self, action: #selector(handleChatButton), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
       let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
//        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    //: MARK: - Button actions
    func handleSearchButton() {
        print("handleSearchButton was tapped!")
    }
    func handleChatButton() {
        print("handleChatButton was tapped")
    }
    
    func setTopContainer() {
        view.addSubview(containerView)
        //: Constraints for the container view
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: containerView)
        view.addConstraintsWithFormat(format: "V:|-22-[v0(50)]", views: containerView)
        
        containerView.addSubview(mojiImageView)
        containerView.addSubview(searchButton)
        containerView.addSubview(newChatButton)
        
        containerView.addConstraintsWithFormat(format: "H:|-11-[v0(27)]-10-[v1][v2(25)]-11-|", views: mojiImageView, searchButton, newChatButton)
        containerView.addConstraintsWithFormat(format: "V:|[v0]|", views: mojiImageView)
        containerView.addConstraintsWithFormat(format: "V:|[v0]|", views: searchButton)
        containerView.addConstraintsWithFormat(format: "V:|[v0]|", views: newChatButton)
    }
    
    func setupViews() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        self.automaticallyAdjustsScrollViewInsets = false
        //: ScrollView & contentView constraints
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: contentView)
        scrollView.addConstraintsWithFormat(format: "V:|[v0]|", views: contentView)
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0))
        contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        contentView.addConstraintsWithFormat(format: "V:|-60-[v0]|", views: collectionView)
        setTopContainer()
    }
    
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //: Light blue color
        view.backgroundColor = UIColor.rgb(red: 60, green: 178, blue: 226)
        setupViews()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: MessagesController.cellId)
    }
    //: MARK: - CollectionView methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessagesController.cellId, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}
