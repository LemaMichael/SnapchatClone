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
import AVFoundation

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
        maximumVideoDuration = 10.0
        shouldUseDeviceOrientation = true
        allowAutoRotate = true
        audioEnabled = true
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        view.addSubview(captureButton)
        view.addConstraintsWithFormat(format: "H:[v0(80)]", views: captureButton)
        view.addConstraintsWithFormat(format: "V:[v0(80)]-57-|", views: captureButton)
        view.addConstraint(NSLayoutConstraint(item: captureButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    //: MARK: - swiftyCam methods
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        if !captureButtonTapped {
            captureButtonTapped = true
            let newVC = PhotoViewController(image: photo)
            /*
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.present(newVC, animated: false, completion: nil)
            }*/
            self.present(newVC, animated: true, completion: nil)
        }
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did Begin Recording")

    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did finish Recording")
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        let newVC = VideoViewController(videoURL: url)
        self.present(newVC, animated: true, completion: nil)
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "Focus"))
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.30, y: 1.30)
        }, completion: { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }, completion: { (success) in
                focusView.removeFromSuperview()
            })
        })
    }
    
    //: MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureButtonTapped = false
        print(123)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
