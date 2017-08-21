//
//  ColorExtension.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/3/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
