//
//  NavigationBar.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/13/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setUpNavigationBar(image: String?) {
        //: Change back button image in Navigation Bar
        if let backImage = image {
            let backButtonImage = UIImage(named: backImage)?.withRenderingMode(.alwaysOriginal)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(popCurrentView))
        }
        //: Transparent UINavigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    func popCurrentView() {
        //: Go back to WelcomeController
        self.navigationController?.popViewController(animated: false)
    }
}
