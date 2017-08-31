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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        pinchToZoom = false
        swipeToZoom = false
        swipeToZoomInverted = false
        tapToFocus = false
        shouldUseDeviceOrientation = false


    }
    
}
