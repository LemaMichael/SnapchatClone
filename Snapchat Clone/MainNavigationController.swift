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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //: Might do something here.....
        if isLoggedIn() {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        } else {
            let welcomeController = WelcomeController()
            viewControllers = [welcomeController]
        }
    }
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
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


