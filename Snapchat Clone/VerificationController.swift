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
    var notGhostImage = 0
    
    let colorArray = [
        UIColor.rgb(red: 223, green: 221, blue: 55),
        UIColor.rgb(red: 254, green: 197, blue: 51),
        UIColor.rgb(red: 223, green: 221, blue: 55),
        UIColor.rgb(red: 40, green: 50, blue: 116),
        UIColor.rgb(red: 238, green: 96, blue: 126),
        UIColor.rgb(red: 141, green: 196, blue: 75),
        UIColor.rgb(red: 40, green: 50, blue: 116),
        UIColor.rgb(red: 238, green: 96, blue: 126),
        UIColor.rgb(red: 181, green: 209, blue: 66)
    ]
    
    let imageDict: [UIImage: Bool] = [
        UIImage(named: "Cool Ghost")! : true,
        UIImage(named: "Happy Ghost")!: true,
        UIImage(named: "Cooler Ghost")!: true,
        UIImage(named: "Droid-1")!: false,
        UIImage(named: "Droid")!: false
    ]
    
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
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 11.5)
        //: Faint red color
        label.textColor =  UIColor.rgb(red: 239, green: 63, blue: 90)
        label.text = "You didn't identify all of the images"
        label.isHidden = true
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
        cv.allowsMultipleSelection = true
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
        /*
         - validPass will be false only if there was an image found that had a false value in imageDict
         - SelectedIndexpaths is used to help determine the cell's image that was selected.
         - count is used to track how many images have a value of true
         - Succes will only happen if:
                 * all images selected have a value of true in the imageDict
                 * the items selected and the amount of notGhostImage's are equal to 9
         */
        print("Button was tapped-----------------------------------")
        var validPass = true
        var count = 0
        guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems else { return }
        print("The selected item count is : \(selectedIndexPaths.count)")
        for index in selectedIndexPaths {
            let cell = collectionView.cellForItem(at: index) as! GhostCell
            let keys =  Array(imageDict.keys)
            for image in keys {
                if cell.imageView.image == image {
                    let result = imageDict[image]!
                    if result {
                        count += 1
                        print("This image is good to go \(result)")
                    } else {
                        print("Wohoo we found an error \(result)")
                        validPass = false
                    }
                }
            }
        }
        print("The total success result is \(count)")
        //: TODO: REMOVE  && selectedIndexPaths.count != 0 && count == selectedIndexPaths.count
        if validPass && selectedIndexPaths.count != 0 && count == selectedIndexPaths.count && notGhostImage + selectedIndexPaths.count == 9 {
            print("we are allowed to leave!")
            self.navigationController?.popViewController(animated: false)
            self.navigationController?.pushViewController(FindFriendsController(), animated: false)
            //present(FindFriendsController(), animated: false, completion: nil)
        }  else if selectedIndexPaths.count != 0 {
            print("Nope try again")
            notGhostImage = 0
            //: Reload the collectionView again for the user to try again!
            for index in selectedIndexPaths {
                collectionView.deselectItem(at: index, animated: false)
                let cell = collectionView.cellForItem(at: index) as! GhostCell
                cell.checkMark.isHidden = true
                cell.contentView.layer.borderColor = nil
                cell.contentView.layer.borderWidth = 0
            }
            continueButton.backgroundColor = grayButtonColor
            UIView.transition(with: collectionView, duration: 0.40, options: .transitionCrossDissolve, animations: {
                self.collectionView.reloadData()
                self.errorLabel.isHidden = false
            })
        }
    }
    
    //: MARK: - Functions that return random numbers
    func randomDegree() -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(360)))
    }
    func randomNum() -> Int {
        return Int(arc4random_uniform(UInt32(colorArray.count)))
    }
    func randomImage() -> Int {
        return Int(arc4random_uniform(UInt32(imageDict.count)))
    }
    
    //: MARK: - CollectionView methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerificationController.cellId, for: indexPath) as! GhostCell
        //: This is where the magic happens.
        cell.contentView.backgroundColor = colorArray[randomNum()]
        let image = Array(imageDict.keys)[randomImage()]
        let val = imageDict[image]!
        if !val {
            notGhostImage += 1
        }
        
        cell.imageView.image = image
        cell.imageView.transform = CGAffineTransform(rotationAngle: randomDegree() *  .pi / 180)
        switch indexPath.row {
        case 0:
            cell.contentView.roundedCorder(.topLeft)
        case 2:
            cell.contentView.roundedCorder(.topRight)
        case 6:
            cell.contentView.roundedCorder(.bottomLeft)
        case 8:
            cell.contentView.roundedCorder(.bottomRight)
        default: break
        }
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
        guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems else { return }
        print("The current count of items selected are \(selectedIndexPaths.count)")
        if selectedIndexPaths.count == 1 {
            continueButton.backgroundColor = purpleButtonColor
            errorLabel.isHidden = true
        }
        print("I selected cell \(indexPath.item)")
        UIView.animate(withDuration: 0.2, animations: {
            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            cell.contentView.layer.borderColor = self.purpleButtonColor.cgColor
            cell.contentView.layer.borderWidth = 5.5
            cell.checkMark.isHidden = false
        }) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                cell.transform = CGAffineTransform.identity
                cell.checkMark.alpha = 1
            })
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GhostCell
        guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems else { return }
        print("The current count of items left selected are \(selectedIndexPaths.count)")
        if selectedIndexPaths.count == 0 {
            continueButton.backgroundColor = grayButtonColor
        }
        print("I deselected \(indexPath.item)")
        
        UIView.animate(withDuration: 0.2, animations: {
            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            cell.contentView.layer.borderColor = nil
            cell.contentView.layer.borderWidth = 0
            cell.checkMark.isHidden = true
        }) { _ in
            UIView.animate(withDuration: 0.20, animations: {
                cell.transform = CGAffineTransform.identity
                cell.checkMark.alpha = 0
            })
        }
    }
    
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        ghostPose.append(UIImage(named: "Cool Ghost-1")!.withRenderingMode(.alwaysOriginal))
        ghostPose.append(UIImage(named: "Cool Ghost")!.withRenderingMode(.alwaysOriginal))
        
        setupNavigationBar(leftImage: "BackButton")
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = false
       // self.edgesForExtendedLayout = []
        //self.navigationController!.navigationBar.isTranslucent = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(ghostView)
        contentView.addSubview(robotLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(errorLabel)
        contentView.addSubview(collectionView)
        view.addSubview(continueButton)
        setupViews()
    }
    //: MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ghostView.startAnimating()
    }
    //: MARK: - viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ghostView.stopAnimating()
    }
    //: MARK: - viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.isMovingFromParentViewController {
            print("View controller was popped")
        }
    }
    //: MARK: - setupViews
    func setupViews() {
        let screenWidth = view.frame.width / 2  - 20
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: contentView)
        scrollView.addConstraintsWithFormat(format: "V:|[v0]|", views: contentView)
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: -44))
        
        contentView.addConstraintsWithFormat(format: "H:|-\(screenWidth)-[v0]-\(screenWidth)-|", views: ghostView)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: robotLabel)
        contentView.addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: descriptionLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: errorLabel)
        contentView.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: collectionView)
        contentView.addConstraintsWithFormat(format: "V:|-25-[v0(50)][v1(30)][v2(20)]-5-[v3(14)]-9-[v4]-130-|", views: ghostView, robotLabel, descriptionLabel, errorLabel, collectionView)
        
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
        setupCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "Cool Ghost")!.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = UIColor.darkGray
        return imageView
    }()
    let checkMark: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Checkmark")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.isHidden = true
        imageView.alpha = 0
        return imageView
    }()
    func setupCell() {
        addSubview(imageView)
        addSubview(checkMark)
        let width = self.frame.size.width / 3.2
        let height = self.frame.size.height / 3.2
        
        addConstraintsWithFormat(format: "H:|-\(width)-[v0]-\(width)-|", views: imageView)
        addConstraintsWithFormat(format: "V:|-\(height)-[v0]-\(height)-|", views: imageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]", views: checkMark)
        addConstraintsWithFormat(format: "V:|-8-[v0(30)]", views: checkMark)
    }
}
