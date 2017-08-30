//
//  RoundedCorner.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/18/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundedCorner(_ corner: UIRectCorner) {
        let cornerRadii = CGSize(width: 9.0, height: 9.0)
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: cornerRadii)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
    
    func roundedCellCorners(_ corner: UIRectCorner) {
        let cornerRadii = CGSize(width: 20.0, height: 20.0)
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: cornerRadii)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
}
