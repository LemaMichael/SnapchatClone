//
//  CamereRollCell.swift
//  Memories
//
//  Created by Michael Lema on 9/10/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit

class CameraRollCell: BaseCollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let photoCellId = "photoCellId"
    static let screenshotCellId = "screenshotCellId"
    static let videoCellId = "videoCellId"
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    //    let containerView: UIView = {
    //        let view = UIView()
    //        view.backgroundColor = UIColor(red: 247/255, green: 248/255, blue: 249/255, alpha: 1)
    //        return view
    //    }()
    lazy var menuBar: PhotoMenuBar = {
        let mb = PhotoMenuBar()
        mb.cameraRollCell = self
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
        collectionView.register(AllPhotosCell.self, forCellWithReuseIdentifier: photoCellId)
        collectionView.register(ScreenshotsCell.self, forCellWithReuseIdentifier: screenshotCellId)
        collectionView.register(VideosCell.self, forCellWithReuseIdentifier: videoCellId)
        
        return collectionView
    }()
    
    override func setupViews() {
        addSubview(view)
        addConstraintsWithFormat(format: "H:|[v0]|", views: view)
        addConstraintsWithFormat(format: "V:|[v0]|", views: view)
        view.addSubview(menuBar)
        view.addSubview(collectionView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(45)]-2-[v1]|", views: menuBar, collectionView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
    }
    //: MARK: - ScrollView Methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = (scrollView.contentOffset.x / 3)
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
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
        if indexPath.item == 1 {
            identifier = CameraRollCell.screenshotCellId
        } else if indexPath.item == 2 {
            identifier = CameraRollCell.videoCellId
        } else {
            identifier = CameraRollCell.photoCellId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: collectionView.frame.height)
    }
}

