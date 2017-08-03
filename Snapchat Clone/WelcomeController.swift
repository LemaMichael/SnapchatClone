//
//  ViewController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 7/30/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {
    
    
    let snapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.rgb(red: 254, green: 250, blue: 55)
        //: Maintain Ghost Icon image centered inside UIImageViwe
        imageView.contentMode = .center
        return imageView
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 239, green: 63, blue: 90)
        button.setTitle("LOG IN", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25)
        button.addTarget(self, action: #selector(showHappyGhost), for: .touchDown)
        button.addTarget(self, action: #selector(hideHappyGhost), for: .touchUpOutside)
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 35, green: 174, blue: 252)
        button.setTitle("SIGN UP", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25)
        button.addTarget(self, action: #selector(pushToNameController), for: .touchUpInside)
        button.addTarget(self, action: #selector(showHappyGhost), for: .touchDown)
        button.addTarget(self, action: #selector(hideHappyGhost), for: .touchUpOutside)
        return button
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(snapImageView)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        setUpViews()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //: Hide a navigation bar from this ViewController
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        //: Set the snapImage to its original state
        snapImageView.image = UIImage(named: "Icon")
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //: Show the navigation bar for other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    //: Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    func setUpViews() {
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: snapImageView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: loginButton)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: signUpButton)
        
        view.addConstraintsWithFormat(format: "V:|[v0][v1(80)][v2(80)]|", views: snapImageView, loginButton, signUpButton)
    }
    
    
    
    //: MARK: - Button targers
    func showHappyGhost() {
        snapImageView.image = UIImage(named: "Happy Icon")
    }
    
    func hideHappyGhost() {
        snapImageView.image = UIImage(named: "Icon")
    }
    
    
    func pushToNameController() {
        self.navigationController?.pushViewController(NameController(), animated: false)
    }
    

    
}

