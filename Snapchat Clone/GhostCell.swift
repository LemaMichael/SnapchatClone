//
//  GhostCell.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/30/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class GhostCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "Cool Ghost")!.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = UIColor.darkGray
        return imageView
    }()
    let checkMark: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Checkmark")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.isHidden = true
        imageView.alpha = 0
        return imageView
    }()
    func setupCell() {
        addSubview(imageView)
        addSubview(checkMark)
        let width = self.frame.size.width / 3.2
        let height = self.frame.size.height / 3.2
        
        addConstraintsWithFormat(format: "H:|-\(width)-[v0]-\(width)-|", views: imageView)
        addConstraintsWithFormat(format: "V:|-\(height)-[v0]-\(height)-|", views: imageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]", views: checkMark)
        addConstraintsWithFormat(format: "V:|-8-[v0(30)]", views: checkMark)
    }
}
