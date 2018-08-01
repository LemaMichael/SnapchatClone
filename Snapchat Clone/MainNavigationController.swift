//
//  MainNavigationController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 9/1/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Loading Screen")
        backgroundImage.contentMode = .scaleAspectFit
        return backgroundImage
    }()
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.insertSubview(backgroundImage, at: 0)
        
        if isLoggedIn() {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.70)
            //viewControllers = [MemoriesController()]
        } else {
            let welcomeController = WelcomeController()
            viewControllers = [welcomeController]
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    //: MARK: - viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        backgroundImage.removeFromSuperview()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIViewController {
    func showLoginController() {
        let left = MessagesController()
        let middle = CameraController()
        let right = StoriesController()
        let top = ProfileController()
        let bottom = MemoriesController()
        let snapContainer = SnapContainerViewController.containerViewWith(left, middleVC: middle, rightVC: right, topVC: top, bottomVC: bottom)
        present(snapContainer, animated: false) {
            //: Maybe we'll do something here later
        }
    }
}


