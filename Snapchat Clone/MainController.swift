//
//  MainController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/21/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class MainController: UIViewController {
    
    lazy var horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        let origin = self.view.frame.width
        view.addSubview(horizontalScrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: horizontalScrollView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: horizontalScrollView)
        
        let messagesView = MessagesController()
        messagesView.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)

        let cameraView = CameraController()
        cameraView.view.frame = CGRect(x: origin, y: 0, width: self.view.frame.width, height: self.view.frame.height)

       let storiesView = StoriesController()
        storiesView.view.frame = CGRect(x: origin * 2, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        horizontalScrollView.addSubview(messagesView.view)
        horizontalScrollView.addSubview(cameraView.view)
        horizontalScrollView.addSubview(storiesView.view)
        
        self.horizontalScrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.height)
        //: Start in the CameraView.
        self.horizontalScrollView.contentOffset = CGPoint(x: self.view.frame.width, y: 0)
    }
}

