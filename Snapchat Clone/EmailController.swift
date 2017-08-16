//
//  EmailController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/15/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class EmailController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("i AM HERE")
        view.backgroundColor = .white
        //self.navigationController?.viewControllers.remove(at: 0)
        /*
         var viewControllers = navigationController?.viewControllers
         viewControllers?.removeFirst(2) //here 2 views to pop index numbers of views
         navigationController?.setViewControllers(viewControllers!, animated: true)
         */
        
        
        setUpNavigationBar(leftImage: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)

    }
    
    

}
