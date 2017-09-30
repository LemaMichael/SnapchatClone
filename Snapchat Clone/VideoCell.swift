//
//  VideosCell.swift
//  Memories
//
//  Created by Michael Lema on 9/10/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit

class VideosCell: BaseCollectionViewCell {
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    override func setupViews() {
        //: Do something
        addSubview(view)
        addConstraintsWithFormat(format: "H:|[v0]|", views: view)
        addConstraintsWithFormat(format: "V:|[v0]|", views: view)
    }
    
}


