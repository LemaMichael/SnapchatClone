//
//  PhoneController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/15/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class PhoneController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let array = navigationController!.viewControllers
        for i in array {
            print("The current item in the navigation stack is: \(i)")
        }
    }
}
