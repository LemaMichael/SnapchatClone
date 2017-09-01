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
    
    let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        return container
    }()
    let mojiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Emoji")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        let searchImage = UIImage(named: "Search")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = UIColor.white
        button.setImage(searchImage, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        button.setTitle(" Search", for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
        return button
    }()
    let flashButton: UIButton = {
        let button = UIButton(type: .custom)
        let flashOff = #imageLiteral(resourceName: "Flash Off").withRenderingMode(.alwaysOriginal)
        button.setImage(flashOff, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        //: Disable button highlight when tapped.
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(toggleFlashTapped), for: .touchUpInside)
        return button
    }()
    
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
    //: MARK: - Button actions
    func handleSearchButton() {
        print("handleSearchButton was tapped!")
    }
    func toggleFlashTapped() {
        flashEnabled = !flashEnabled
        if flashEnabled == true {
            flashButton.setImage(#imageLiteral(resourceName: "Flash On"), for: UIControlState())
        } else {
            flashButton.setImage(#imageLiteral(resourceName: "Flash Off"), for: UIControlState())
        }
    }
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
        view.addSubview(containerView)
        //: Capture Button Constraints
        view.addConstraintsWithFormat(format: "H:[v0(80)]", views: captureButton)
        view.addConstraintsWithFormat(format: "V:[v0(80)]-57-|", views: captureButton)
        view.addConstraint(NSLayoutConstraint(item: captureButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        //: ContainerView constraints
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: containerView)
        view.addConstraintsWithFormat(format: "V:|-22-[v0(50)]", views: containerView)
        
        containerView.addSubview(mojiImageView)
        containerView.addSubview(searchButton)
        containerView.addSubview(flashButton)
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor(white: 0.7, alpha: 0.4)
        containerView.addSubview(bottomView)
        
        containerView.addConstraintsWithFormat(format: "H:|-11-[v0(27)]-10-[v1]-[v2(21)]-11-|", views: mojiImageView, searchButton, flashButton)
        containerView.addConstraintsWithFormat(format: "V:|[v0]|", views: mojiImageView)
        containerView.addConstraintsWithFormat(format: "V:|[v0]|", views: searchButton)
        
        //: Flash Button vertical constraints
        containerView.addConstraintsWithFormat(format: "V:[v0(21)]", views: flashButton)
        containerView.addConstraint(NSLayoutConstraint(item: flashButton, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0))
        
        //: BottomView constraints
        containerView.addConstraintsWithFormat(format: "H:|[v0]|", views: bottomView)
        containerView.addConstraintsWithFormat(format: "V:[v0(0.25)]|", views: bottomView)

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
