//
//  MessagesController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/22/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class MessagesController: UIViewController {
    let mojiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Empty Ghost")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        let searchImage = UIImage(named: "Search")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = UIColor.white
        button.setImage(searchImage, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        button.setTitle(" Chat", for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
        return button
    }()
    let newChatButton: UIButton = {
        let button = UIButton(type: .system)
        let searchImage = UIImage(named: "New Chat")?.withRenderingMode(.alwaysOriginal)
        button.setImage(searchImage, for: .normal)
        button.addTarget(self, action: #selector(handleChatButton), for: .touchUpInside)
        return button
    }()
    
    //: MARK: Button actions
    func handleSearchButton() {
        print("handleSearchButton was tapped!")
    }
    func handleChatButton() {
        print("handleChatButton was tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //: Light blue color
        view.backgroundColor = UIColor.rgb(red: 60, green: 178, blue: 226)
        setTopContainer()
    }
    
    func setTopContainer() {
        let container = UIView()
        container.backgroundColor = .clear
        view.addSubview(container)
        //: Constraints for the container view
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: container)
        view.addConstraintsWithFormat(format: "V:|-22-[v0(50)]", views: container)
        
        container.addSubview(mojiImageView)
        container.addSubview(searchButton)
        container.addSubview(newChatButton)
        
        container.addConstraintsWithFormat(format: "H:|-11-[v0(27)]-10-[v1][v2(25)]-11-|", views: mojiImageView, searchButton, newChatButton)
        container.addConstraintsWithFormat(format: "V:|[v0]|", views: mojiImageView)
        container.addConstraintsWithFormat(format: "V:|[v0]|", views: searchButton)
        container.addConstraintsWithFormat(format: "V:|[v0]|", views: newChatButton)
    }
}
