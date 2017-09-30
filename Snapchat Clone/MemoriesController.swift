//
//  MemoriesController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/26/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit

class MemoriesController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let snapsCellId = "cellId"
    static let cameraRollCellId = "cameraRollCellId"
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
    let mainContainter: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        return container
    }()
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SnapCell.self, forCellWithReuseIdentifier: snapsCellId)
        collectionView.register(CameraRollCell.self, forCellWithReuseIdentifier: cameraRollCellId)
        return collectionView
    }()
    //: MARK: - Button actions
    @objc func handleSearchButton() {
        print("Search Button Tapped")
    }
    @objc func enlargeSelectButton() {
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
    @objc func shrinkSelectButton() {
        selectButton.transform = .identity
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 39/255, blue: 78/255, alpha: 1)
        
        setupViews()
        setupMenuBar()
    }
    func setupViews() {
        view.addSubview(containerView)
        //: ContainerView constraints
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: containerView)
        view.addConstraintsWithFormat(format: "V:|-22-[v0(50)]", views: containerView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: containerView)
        
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
        
        view.addSubview(mainContainter)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: mainContainter)
        view.addConstraint(NSLayoutConstraint(item: mainContainter, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstraintsWithFormat(format: "V:[v0]|", views: mainContainter)
        
        //: Add the collection View to the mainContainer
        mainContainter.addSubview(collectionView)
        mainContainter.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        mainContainter.addConstraintsWithFormat(format: "V:[v0]|", views: collectionView)
        mainContainter.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: mainContainter, attribute: .top, multiplier: 1, constant: 60))
        
        
    }
    func setupMenuBar() {
        mainContainter.addSubview(menuBar)
        mainContainter.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        mainContainter.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        //menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        mainContainter.addConstraint(NSLayoutConstraint(item: menuBar, attribute: .top, relatedBy: .equal, toItem: self.mainContainter, attribute: .top, multiplier: 1, constant: 8))
    }
    //: MARK: - ScrollView Methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = (scrollView.contentOffset.x / 4)
        //: TODO: INCREASE the width when scrolling
        //menuBar.horizontalBarWidthAnchorConstraint?.constant = (scrollView.contentOffset.x / 3)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
    }
    func scrollToMenuIndex(_ menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
    }
    //: MARK: CollectionView methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
        if indexPath.item == 1 {
            identifier = MemoriesController.cameraRollCellId
        } else {
            identifier = MemoriesController.snapsCellId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mainContainter.frame.width, height: collectionView.frame.height)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let cornerRadii = CGSize(width: 20.0, height: 20.0)
        let path = UIBezierPath(roundedRect: mainContainter.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: cornerRadii)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = mainContainter.bounds
        shapeLayer.path = path.cgPath
        mainContainter.layer.mask = shapeLayer
    }
}
