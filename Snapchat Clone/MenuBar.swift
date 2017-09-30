//
//  MenuBar.swift
//  Memories
//
//  Created by Michael Lema on 9/10/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        //cv.backgroundColor = .blue
        return cv
    }()
    
    let cellId = "cellId"
    let labelNames = ["SNAPS", "CAMERA ROLL"]
    
    var homeController: MemoriesController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:[v0(200)]", views: collectionView)
        addConstraint(NSLayoutConstraint(item: collectionView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())
        
        setupHorizontalBar()
    }
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    var horizontalBarWidthAnchorConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(red: 230/255, green: 44/255, blue: 87/255, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        //need x, y, width, height constraints
        // horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: collectionView.leftAnchor)
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: collectionView.leftAnchor, constant: 0)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -13).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1/2).isActive = true
        
        //        let fontAttributes = [NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 14)!]
        //        let text = "SNAP"
        //        let size = (text as NSString).size(withAttributes: fontAttributes)
        //        horizontalBarWidthAnchorConstraint = horizontalBarView.widthAnchor.constraint(equalToConstant: size.width + 10)
        horizontalBarWidthAnchorConstraint?.isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeController?.scrollToMenuIndex(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        cell.label.text = labelNames[indexPath.item]
        cell.tintColor =  UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MenuCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        label.font = UIFont(name: "Avenir-Heavy", size: 14)
        label.text = "SNAPS"
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            let pinkColor = UIColor(red: 230/255, green: 44/255, blue: 87/255, alpha: 1)
            let grayColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
            label.textColor = isHighlighted ? pinkColor : grayColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            let pinkColor = UIColor(red: 230/255, green: 44/255, blue: 87/255, alpha: 1)
            let grayColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
            label.textColor = isSelected ? pinkColor : grayColor
        }
    }
    
    func setupViews() {
        addSubview(label)
        addConstraintsWithFormat(format: "H:|[v0]|", views: label)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: label)
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}

