//
//  ConstraintsExtension.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/3/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit



extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
