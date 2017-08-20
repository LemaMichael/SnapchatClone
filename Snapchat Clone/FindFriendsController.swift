//
//  FindFriendsController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/19/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class FindFriendsController: UIViewController {
    
    let images = [
        UIImageView(image: UIImage(named: "Cool Ghost")),
        UIImageView(image: UIImage(named:"Happy Ghost")),
        UIImageView(image: UIImage(named: "Cooler Ghost")),
        UIImageView(image: UIImage(named: "Tongue Ghost"))
    ]
    
    lazy var skipButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 15)
        button.setTitleColor(UIColor.rgb(red: 206, green: 212, blue: 218), for: .normal)
        button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        return button
    }()
    let friendsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Medium", size: 19)
        label.text = "Find your friends"
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 14)
        label.textColor =  UIColor.rgb(red: 154, green: 159, blue: 167)
        label.numberOfLines = 0
        label.text = "See which of your contacts are on Snapchat clone!"
        return label
    }()
    let learnLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 154, green: 159, blue: 167)
        label.font = UIFont(name: "Avenir-Medium", size: 12)
        label.textAlignment = .right
        label.text = "Learn more in our"
        return label
    }()
    let policyButton: UIButton = {
        //: type is custom because I don't want the button to highlight when tapped
        let button = UIButton(type: .custom)
        button.setTitle("Privacy Policy", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 12)
        button.setTitleColor(UIColor(red:0.11, green:0.51, blue:0.98, alpha:1.0), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(goToLink), for: .touchUpInside)
        return button
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.learnLabel, self.policyButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        var space = " "
        var font = UIFont(name: "Avenir-Medium", size: 12)
        var stringSize = space.size(attributes: [NSFontAttributeName: font!])
        //: Proper spacing between the label and button
        stackView.spacing = stringSize.width
        return stackView
    }()
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        button.backgroundColor = UIColor.rgb(red: 153, green: 87, blue: 159)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        //: Make button round
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var imagesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: self.images)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    //: MARK: - Button actions
    func skipTapped() {
        print("skip button tapped")
    }
    func goToLink() {
        guard let url = URL(string: "https://en.wikipedia.org/wiki/Privacy_policy") else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(url)
        }
    }
    func continueButtonTapped() {
        print("Continue button was tapped!")
    }
    
    //: MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(skipButton)
        view.addSubview(imagesStackView)
        view.addSubview(friendsLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(stackView)
        view.addSubview(continueButton)
        setUpViews()
    }
    func setUpViews() {
        view.addConstraintsWithFormat(format: "H:[v0]-16-|", views: skipButton)
        view.addConstraintsWithFormat(format: "V:|-12-[v0]", views: skipButton)
        
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: imagesStackView)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: friendsLabel)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: descriptionLabel)
        view.addConstraintsWithFormat(format: "H:|-68-[v0]-68-|", views: continueButton)
        view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        view.addConstraintsWithFormat(format: "V:[v0]-[v1]-4-[v2]-5-[v3(30)]-65-[v4(44)]-25-|", views: imagesStackView, friendsLabel, descriptionLabel, stackView, continueButton)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print("----------BEGIN THE ANIMATION!----------")
        UIView.animate(withDuration: 2.5, delay: 0.5, options: [.curveEaseOut, .repeat, .autoreverse], animations: {
            self.imagesStackView.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
            self.imagesStackView.frame.origin.y = +self.view.frame.height / 2
        }, completion: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //: Stop the animation!
        self.imagesStackView.layer.removeAllAnimations()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
