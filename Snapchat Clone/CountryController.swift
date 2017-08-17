//
//  CountryController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/16/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class CountryController: UITableViewController {
    static let celld = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setUpNavigationBar(leftImage: "BackButton")

        //: Change back the shadowImage to default
        self.navigationController?.navigationBar.shadowImage = nil
        navigationItem.title = "Select Country"
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 20)!]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

