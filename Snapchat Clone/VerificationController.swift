//
//  VerificationController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/18/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit


class VerificationController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let cellId = "cellId"
    private let purpleButtonColor =  UIColor.rgb(red: 153, green: 87, blue: 159)
    private let grayButtonColor = UIColor.rgb(red: 185, green: 192, blue: 199)
    var ghostPose = [UIImage]()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    lazy var ghostView: UIImageView = {
        let imageView = UIImageView()
        //imageView.contentMode = .scaleAspectFit
        imageView.animationImages = self.ghostPose
        imageView.animationDuration = 1.5
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let robotLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Medium", size: 19)
        label.text = "Prove you aren't a robot"
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 14.3)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = "Select all images containing a ghost."
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
        cv.register(GhostCell.self, forCellWithReuseIdentifier: VerificationController.cellId)
        return cv
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        button.backgroundColor = self.grayButtonColor
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        //: Make button round
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        return button
    }()
    
    //: Button actions
    func continueButtonTapped() {
        print("Button was tapped")
    }
    //: MARK: - Functions to adjust imageView
    func randomNumber(_ maxNumber: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(maxNumber)))
    }
    
    //: CollectionView methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerificationController.cellId, for: indexPath) as! GhostCell
        cell.backgroundView = UIImageView(image: UIImage(named: "Background3"))
    
        let angleInDegree = randomNumber(360)
        cell.imageView.transform = CGAffineTransform(rotationAngle: angleInDegree *  .pi / 180)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 3
        let height = collectionView.frame.size.height / 3
        return CGSize(width: width - 5, height: height - 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GhostCell
        print("You got me!")
        print("row: \(indexPath.row)")
        
        if cell.checkMark.isHidden {
            cell.layer.borderColor = purpleButtonColor.cgColor
            cell.layer.borderWidth = 6
            //cell.layer.cornerRadius = 5
            cell.checkMark.isHidden = false
        } else {
            cell.layer.borderColor = nil
            cell.layer.borderWidth = 0
            //cell.layer.cornerRadius = 5
            cell.checkMark.isHidden = true
        }
    }
    
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        ghostPose.append(UIImage(named: "Cool Ghost-1")!.withRenderingMode(.alwaysOriginal))
        ghostPose.append(UIImage(named: "Cool Ghost")!.withRenderingMode(.alwaysOriginal))
     
        setUpNavigationBar(leftImage: "BackButton")
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = false
       // self.edgesForExtendedLayout = []
        //self.navigationController!.navigationBar.isTranslucent = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(ghostView)
        contentView.addSubview(robotLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(collectionView)
        view.addSubview(continueButton)
        setUpViews()
    }
    //: MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ghostView.startAnimating()
    }
    //: MARK: - viewWillDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ghostView.stopAnimating()
    }
    //: MARK: - setUpViews
    func setUpViews() {
        let screenWidth = view.frame.width / 2  - 20
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: contentView)
        scrollView.addConstraintsWithFormat(format: "V:|[v0]|", views: contentView)
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: -44))
        
        contentView.addConstraintsWithFormat(format: "H:|-\(screenWidth)-[v0]-\(screenWidth)-|", views: ghostView)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: robotLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: descriptionLabel)
        contentView.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: collectionView)
 
        contentView.addConstraintsWithFormat(format: "V:|[v0(50)][v1(40)]-1-[v2(20)]-20-[v3]-140-|", views: ghostView, robotLabel, descriptionLabel, collectionView)
        
        //: Constraints for the continue button
        view.addConstraintsWithFormat(format: "H:|-68-[v0]-68-|", views: continueButton)
        view.addConstraintsWithFormat(format: "V:[v0(44)]-25-|", views: continueButton)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

//: MARK: - CollectionView Cell
class GhostCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cool Ghost")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = UIColor.darkGray
        return imageView
    }()
    let checkMark: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Checkmark")?.withRenderingMode(.alwaysOriginal)
        imageView.tintColor = UIColor.rgb(red: 153, green: 87, blue: 159)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.isHidden = true
        return imageView
    }()
    func setUpCell() {
        addSubview(imageView)
        addSubview(checkMark)
        addConstraintsWithFormat(format: "H:|-25-[v0]-25-|", views: imageView)
        addConstraintsWithFormat(format: "V:|-35-[v0]-35-|", views: imageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(25)]", views: checkMark)
        addConstraintsWithFormat(format: "V:|-8-[v0(25)]", views: checkMark)
    }
}
