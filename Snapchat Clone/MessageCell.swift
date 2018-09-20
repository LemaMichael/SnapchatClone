//
//  MessageCell.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/29/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class MessageCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let statusView: UIImageView = {
        let statusView = UIImageView()
        statusView.image = UIImage(named: "Opened Sent")?.withRenderingMode(.alwaysTemplate)
        statusView.tintColor = UIColor.rgb(red: 14, green: 173, blue: 255)
        statusView.contentMode = .scaleAspectFit
        return statusView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        //: Display username and received date
        label.numberOfLines = 2
        
        let attributedText = NSMutableAttributedString(string: "John Appleseed 🤑🤢", attributes: [NSFontAttributeName : UIFont(name: "Avenir-Medium", size: 15)!])
        //: Set the received date
        attributedText.append(NSAttributedString(string: "\nReceived Aug 20", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName : UIColor.rgb(red: 174, green: 182, blue: 189)]))
        //: Increase spacing between lines
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        label.attributedText = attributedText
        return label
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 247, green: 248, blue: 249)
        return view
    }()
    
    let streaksLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 14)
        label.textAlignment = .right
        label.text = "1130🔥😎😊"
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            self.contentView.backgroundColor = isHighlighted ? UIColor.rgb(red: 238, green: 238, blue: 238) : .white
        }
    }
    
    func setupViews() {
        addSubview(statusView)
        addSubview(borderView)
        addSubview(nameLabel)
        addSubview(streaksLabel)
        backgroundColor = .white
        //: statusView Constraints
        addConstraintsWithFormat(format: "H:|-14-[v0(19)]-15-[v1][v2(100)]-12-|", views: statusView, nameLabel, streaksLabel)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: statusView)
        addConstraint(NSLayoutConstraint(item: statusView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        //: borderView constraints
        addConstraintsWithFormat(format: "H:|[v0]|", views: borderView)
        addConstraintsWithFormat(format: "V:[v0(0.5)]|", views: borderView)
        
        //: usernameLabel
        //addConstraintsWithFormat(format: "V:[v0(35)]", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(40)]", views: nameLabel)
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        //: StreaksLabel
        addConstraintsWithFormat(format: "V:[v0(15)]", views: streaksLabel)
        addConstraint(NSLayoutConstraint(item: streaksLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
}
