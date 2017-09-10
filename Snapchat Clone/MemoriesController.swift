//
//  MemoriesController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/26/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class MemoriesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    var topConstraint:  NSLayoutConstraint?

    let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        return container
    }()
    let mojiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "White Icon")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        let searchImage = UIImage(named: "Search")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = UIColor.white
        button.setImage(searchImage, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        button.setTitle(" Search", for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
        return button
    }()
    let selectButton: UIButton = {
        let button = UIButton(type: .custom)
        let searchImage = UIImage(named: "Select")?.withRenderingMode(.alwaysTemplate)
        button.setImage(searchImage, for: .normal)
        button.tintColor = .white
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(enlargeSelectButton), for: .touchDown)
        button.addTarget(self, action: #selector(shrinkSelectButton), for: .touchDragOutside)
        return button
    }()
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    //: MARK: - Button actions
    func handleSearchButton() {
        print("Search Button Tapped")
    }
    func enlargeSelectButton() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseOut,
                       animations: {
                        self.selectButton.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }, completion: { (succes: Bool) in
            //: Do something here later
        })
    }
    func shrinkSelectButton() {
        selectButton.transform = .identity
    }
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //: Light red color
        view.backgroundColor = UIColor.rgb(red: 246, green: 39, blue: 78)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        setupViews()
    }
    func setupViews() {
        //: Add the collectionView first so the containerView can be above (on top) of collectionView
        view.addSubview(collectionView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 75, left: 0, bottom: 0, right: 0)
        
        view.addSubview(containerView)
        //: ContainerView constraints
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: containerView)
        //view.addConstraintsWithFormat(format: "V:|-22-[v0(50)]", views: containerView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: containerView)
        
        //: The containerView's top constraint will be updated when scrolling
        topConstraint = NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 22)
        view.addConstraint(topConstraint!)
        
        containerView.addSubview(mojiImageView)
        containerView.addSubview(searchButton)
        containerView.addSubview(selectButton)
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor(white: 0.7, alpha: 0.4)
        containerView.addSubview(bottomView)
        
        containerView.addConstraintsWithFormat(format: "H:|-11-[v0(23.5)]-10-[v1][v2(25)]-11-|", views: mojiImageView, searchButton, selectButton)
        containerView.addConstraintsWithFormat(format: "V:|[v0]|", views: searchButton)
        
        //: MojiImageView constraints
        containerView.addConstraintsWithFormat(format: "V:[v0(23.5)]", views: mojiImageView)
        containerView.addConstraint(NSLayoutConstraint(item: mojiImageView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0))
        //: selectButton Constraints
        containerView.addConstraintsWithFormat(format: "V:[v0(23.5)]", views: selectButton)
        containerView.addConstraint(NSLayoutConstraint(item: selectButton, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    //: MARK: - CollectionView methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .white
        if indexPath.item == 0 {
            cell.roundedCellCorners([.topLeft, .topRight])
        } else {
            //: Issue with cell recycling where other cells were rounded
            cell.layer.mask = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //: The top is zero
        let offset = scrollView.contentOffset.y
        if -offset < 90 {
            topConstraint?.constant = 22 - (-offset / 10)
        }
    }
}

