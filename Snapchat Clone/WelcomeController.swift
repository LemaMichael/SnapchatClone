//
//  ViewController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 7/30/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit
import AVFoundation

class WelcomeController: UIViewController {
    
    //: MARK: - Display user's front facing camera
    let captureSession = AVCaptureSession()
    var videoLayer: CALayer!
    var captureDevice: AVCaptureDevice!
    
    
    //: MARK: - Display snap icon and buttons
    let snapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.rgb(red: 254, green: 250, blue: 55).withAlphaComponent(0.981)
        //: Maintain Ghost Icon image centered inside UIImageViwe
        imageView.contentMode = .center
        return imageView
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 239, green: 63, blue: 90)
        button.setTitle("LOG IN", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25)
        button.addTarget(self, action: #selector(showHappyGhost), for: .touchDown)
        button.addTarget(self, action: #selector(hideHappyGhost), for: .touchUpOutside)
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 35, green: 174, blue: 252)
        button.setTitle("SIGN UP", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25)
        button.addTarget(self, action: #selector(pushToNameController), for: .touchUpInside)
        button.addTarget(self, action: #selector(showHappyGhost), for: .touchDown)
        button.addTarget(self, action: #selector(hideHappyGhost), for: .touchUpOutside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        setUpViews()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //: Hide a navigation bar from this ViewController
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        //: Set the snapImage to its original state
        snapImageView.image = UIImage(named: "Icon")
        
        //: Setup the camera
        setUpCamera()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //: Show the navigation bar for other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    //: Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    func setUpViews() {
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: loginButton)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: signUpButton)
        view.addConstraintsWithFormat(format: "V:[v0(80)][v1(80)]|", views: loginButton, signUpButton)
    }
    
    
    //: MARK: - Button targers
    func showHappyGhost() {
        snapImageView.image = UIImage(named: "Happy Icon")
    }
    
    func hideHappyGhost() {
        snapImageView.image = UIImage(named: "Icon")
    }
    
    
    func pushToNameController() {
        self.captureSession.stopRunning()
        self.navigationController?.pushViewController(NameController(), animated: false)
    }
    
    //: MARK: - Set up Camera
    func setUpCamera() {
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        //: Find devices by device type located in the front of the system hardware
        if let availableDevices = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.front).devices {
            captureDevice = availableDevices.first
            beginCaptureSession()
        }
        
    }
    
    func beginCaptureSession() {
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            //: Add the device input just once each time the view will appear
            if captureSession.inputs.isEmpty {
                self.captureSession.addInput(captureDeviceInput)
            }
            
        } catch let err {
            print(err.localizedDescription)
        }
        
        
        if let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession) {
            
            videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoLayer = videoPreviewLayer
            view.layer.addSublayer(videoLayer)
            
            //: Determine screen height (removed 160 points due to the height of buttons)
            let screenHeight: CGFloat = UIScreen.main.bounds.height
            let reducedHeight: CGFloat = screenHeight - 160
            
            videoLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: reducedHeight)

            //: Now that the videoLayer's frame is set, we can set the snapImageView frame as well
            snapImageView.frame = videoLayer.frame
            view.addSubview(snapImageView)
            
            captureSession.startRunning()
            
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString):NSNumber(value:kCVPixelFormatType_32BGRA)]
            dataOutput.alwaysDiscardsLateVideoFrames = true
            
            if captureSession.canAddOutput(dataOutput) {
                captureSession.addOutput(dataOutput)
            }
            
            captureSession.commitConfiguration()
            
        }
    }
 
    
}
