//
//  UnderlinedTextFieldExtension.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/7/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit

extension UITextField {
    //: Create an underlined UITextField
    func setUnderlinedBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        //self.layer.sublayerTransform = CATransform3DMakeTranslation(0, 7.5, 0)
    }
}

