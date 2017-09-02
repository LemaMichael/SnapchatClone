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
    let switchCameraButton: UIButton = {
        let button = UIButton(type: .custom)
        let frontCam = #imageLiteral(resourceName: "Switch Off").withRenderingMode(.alwaysOriginal)
        button.setImage(frontCam, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        //: Disable button highlight when tapped.
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(toggleCameraSwitch), for: .touchUpInside)
        return button
    }()
    lazy var instructionsView: UIView = {
        let instructionsView = UIView()
        instructionsView.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        return instructionsView
    }()
    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        let message = "Tap to take a photo. Hold to\ntake a video."
        let tapRange = (message as NSString).range(of: "Tap")
        let holdRange = (message as NSString).range(of: "Hold")
        let attributedString = NSMutableAttributedString(string: message)
        let yellowColor = UIColor.rgb(red: 252, green: 177, blue: 0)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: yellowColor, range: tapRange)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: yellowColor, range: holdRange)
        label.attributedText = attributedString
        label.font = UIFont(name: "Avenir-Medium", size: 19.5)
        return label
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
    func toggleCameraSwitch(){
        //: TODO: - Add button bounce animation
        switchCamera()
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
    fileprivate func isFirstLaunch() -> Bool {
        return UserDefaults.standard.isFirstLaunch()
    }
    
    func changeButtonImage() {
        guard let currentImage = switchCameraButton.currentImage else { return }
        if currentImage.isEqual(#imageLiteral(resourceName: "Switch On")){
            switchCameraButton.setImage(#imageLiteral(resourceName: "Switch Off"), for: UIControlState())
        } else {
            switchCameraButton.setImage(#imageLiteral(resourceName: "Switch On"), for: UIControlState())
        }
    }
    func removeInstructionsView() {
        guard isFirstLaunch() == true else { return }
        UserDefaults.standard.setIsFirstLaunch(value: false)
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            self.instructionsView.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
        }, completion: { (success) in
            UIView.animate(withDuration: 0.20, delay: 0.5, options: .curveEaseInOut, animations: {
                self.instructionsView.alpha = 0.0
                self.instructionsView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }, completion: { (success) in
                //: Will remove any view in the subtree (instructionsLabel)
                self.instructionsView.removeFromSuperview()
            })
        })
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
        containerView.addSubview(switchCameraButton)
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor(white: 0.7, alpha: 0.4)
        containerView.addSubview(bottomView)
        
        containerView.addConstraintsWithFormat(format: "H:|-11-[v0(27)]-10-[v1]-[v2(21.5)]-25-[v3(25)]-11-|", views: mojiImageView, searchButton, flashButton, switchCameraButton)
        containerView.addConstraintsWithFormat(format: "V:|[v0]|", views: mojiImageView)
        containerView.addConstraintsWithFormat(format: "V:|[v0]|", views: searchButton)
        
        //: Flash Button vertical constraints
        containerView.addConstraintsWithFormat(format: "V:[v0(21.5)]", views: flashButton)
        containerView.addConstraint(NSLayoutConstraint(item: flashButton, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0))
        
        //: switchCameraButton vertical constraints
        containerView.addConstraintsWithFormat(format: "V:[v0(25)]", views: switchCameraButton)
        containerView.addConstraint(NSLayoutConstraint(item: switchCameraButton, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0))
        
        //: BottomView constraints
        containerView.addConstraintsWithFormat(format: "H:|[v0]|", views: bottomView)
        containerView.addConstraintsWithFormat(format: "V:[v0(0.25)]|", views: bottomView)
        
        if isFirstLaunch() {
            view.addSubview(instructionsView)
            instructionsView.addSubview(instructionsLabel)
            //: instructionsView constraints
            view.addConstraintsWithFormat(format: "H:|[v0]|", views: instructionsView)
            view.addConstraintsWithFormat(format: "V:[v0(80)]", views: instructionsView)
            view.addConstraint(NSLayoutConstraint(item: instructionsView, attribute: .bottom, relatedBy: .equal, toItem: captureButton, attribute: .top, multiplier: 1, constant: -24))
            //: Label constraints
            instructionsView.addConstraintsWithFormat(format: "V:|[v0]|", views: instructionsLabel)
            instructionsView.addConstraintsWithFormat(format: "H:[v0(280)]", views: instructionsLabel)
            instructionsView.addConstraint(NSLayoutConstraint(item: instructionsLabel, attribute: .centerX, relatedBy: .equal, toItem: instructionsView, attribute: .centerX, multiplier: 1, constant: 0))
        }
    }
    //: MARK: - swiftyCam methods
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        print("Did take photo")
        removeInstructionsView()
        let newVC = PhotoViewController(image: photo)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.present(newVC, animated: false, completion: {
                //: What is there to do?
            })
        }
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did Begin Recording")
        removeInstructionsView()
        growButtonAnimation()
        UIView.animate(withDuration: 0.15, animations: {
            self.containerView.alpha = 0.0
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.alpha = 0.0
        })
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did finish Recording")
        stopButtonAnimation()
        UIView.animate(withDuration: 3.0, animations: {
            self.containerView.alpha = 1.0
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.alpha = 1.0
        })
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
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
        changeButtonImage()
    }
    
    func growButtonAnimation() {
        UIView.animate(withDuration: 0.78,
                       delay: 0,
                       //: The closer the value is to zero, the greater increase in oscillation
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 1.0,
            options: [.autoreverse, .repeat],
            animations: {
                self.captureButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        },
            completion: { (success) in
                self.captureButton.transform = .identity
        })
    }
    func stopButtonAnimation() {
        captureButton.transform = .identity
    }
    
    //: MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        SwiftyCamButton.isTapped = false
        view.superview?.isUserInteractionEnabled = false
        view.isUserInteractionEnabled = false
        perform(#selector(enableUserInteraction), with: nil, afterDelay: 0.5)
        
    }
    
    func enableUserInteraction() {
        view.superview?.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
    }
}
