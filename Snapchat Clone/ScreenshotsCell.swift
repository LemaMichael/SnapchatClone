//
//  ScreenshotsCell.swift
//  Memories
//
//  Created by Michael Lema on 9/10/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit
import Photos

class ScreenshotsCell: BaseCollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var screenshotsArray = [UIImage]()
    static let cellId = "cellId"
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()
    
    override func setupViews() {
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        //: Hmmm. Is this a good idea? It doesn't slow down the UI.
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            self.collectPhotos()
            DispatchQueue.main.async {
                // Run UI Updates
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectPhotos() {
        //let frame = collectionView.frame.width / 3
        let imageManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .opportunistic
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let albumsPhoto: PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        
        albumsPhoto.enumerateObjects ({ (collection, index, object) in
            if collection.localizedTitle == "Screenshots" {
                let fetchResult = PHAsset.fetchAssets(in: collection, options: fetchOptions)
                if fetchResult.count > 0 {
                    for index in 0..<fetchResult.count {
                        imageManager.requestImage(for: fetchResult.object(at: index), targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
                            self.screenshotsArray.append(image!)
                        })
                    }
                }
            }
        })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshotsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotsCell.cellId, for: indexPath) as! ImageCell
        cell.imageView.image = screenshotsArray[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame.width / 3
        return CGSize(width: frame - 1, height: frame - 1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //: Do something here later
    }
}

class ImageCell: BaseCollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    override func setupViews() {
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
    }
}

