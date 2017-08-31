//
//  PhotoViewController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/30/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class PhotoViewController: UIViewController {
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        //imageView.image = nil
        return imageView
    }()
    let cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        let cancelImage = UIImage(named: "Close")?.withRenderingMode(.alwaysOriginal)
        button.setImage(cancelImage, for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    init(image: UIImage) {
        //: This allows you to initialize your custom UIViewController without a nib or bundle.
        super.init(nibName: nil, bundle: nil)
        backgroundImageView.image = image
    }
    //: This is necessary when extending the superclass
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(cancelButton)
        //: backgroundImageView Constraints
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: backgroundImageView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: backgroundImageView)
        
        //: cancelButton Constraints
        view.addConstraintsWithFormat(format: "H:|-17-[v0(17)]", views: cancelButton)
        view.addConstraintsWithFormat(format: "V:|-21-[v0(17)]", views: cancelButton)
    }
    //: Button actons
    func handleCancel() {
        UIView.animate(withDuration: 0.30, delay: 0, options: [.curveLinear], animations: {
            self.cancelButton.transform = CGAffineTransform(scaleX: 1.50, y: 1.50)
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
