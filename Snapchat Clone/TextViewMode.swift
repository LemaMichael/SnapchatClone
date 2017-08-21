//
//  TextViewMode.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/20/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setLeftImage(_ image: UIImage, padding: Int) {
        let size = 10
        let view = UIView(frame: CGRect(x: 0, y: 0, width: size + padding / 2, height: size))
        let imageView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        imageView.image = image
        view.addSubview(imageView)
        leftView = view
        leftViewMode = .always
    }
    func modifyLeftImage(_ image: UIImage, padding: Int) {
        let size = 10
        let view = UIView(frame: CGRect(x: 0, y: 0, width: size + padding / 2, height: size))
        let imageView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        imageView.tintColor = UIColor.white
        imageView.image = image
        view.addSubview(imageView)
        leftView = view
        leftViewMode = .always
    }
}
