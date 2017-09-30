//
//  BaseCollectionViewCell.swift
//  Memories
//
//  Created by Michael Lema on 9/10/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit


class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
    }
}

