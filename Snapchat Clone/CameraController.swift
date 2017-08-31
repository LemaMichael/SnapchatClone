//
//  CameraController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/22/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit
import SwiftyCam

class CameraController: SwiftyCamViewController, SwiftyCamViewControllerDelegate {
    private var captureButtonTapped = false
    
    lazy var captureButton: SwiftyCamButton = {
        let button = SwiftyCamButton(frame: CGRect.zero)
        button.delegate = self
        let circleImage = UIImage(named: "Empty Circle")?.withRenderingMode(.alwaysOriginal)
        button.setImage(circleImage, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.clipsToBounds = true
        //: Disable button highlight when tapped.
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraDelegate = self
        
        view.addSubview(captureButton)
        view.addConstraintsWithFormat(format: "H:[v0(80)]", views: captureButton)
        view.addConstraintsWithFormat(format: "V:[v0(80)]-57-|", views: captureButton)
        view.addConstraint(NSLayoutConstraint(item: captureButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        if !captureButtonTapped {
            captureButtonTapped = true
            let newVC = PhotoViewController(image: photo)
            self.present(newVC, animated: true, completion: nil)
        }
    }
    //: MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureButtonTapped = false
    }
}
