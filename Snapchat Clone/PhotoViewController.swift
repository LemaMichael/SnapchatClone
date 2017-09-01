//
//  PhotoViewController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/30/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class PhotoViewController: UIViewController {
    private var hasDownloadedImage = false
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        //imageView.image = nil
        return imageView
    }()
    let cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        let cancelImage = UIImage(named: "Close")?.withRenderingMode(.alwaysOriginal)
        button.setImage(cancelImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    let downloadButton: UIButton = {
        let button = UIButton(type: .custom)
        let downloadImage = UIImage(named: "Download")?.withRenderingMode(.alwaysOriginal)
        button.setImage(downloadImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleDownload), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    //: MARK: - init
    init(image: UIImage) {
        //: This allows you to initialize your custom UIViewController without a nib or bundle.
        super.init(nibName: nil, bundle: nil)
        backgroundImageView.image = image
    }
    //: This is necessary when extending the superclass
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(cancelButton)
        view.addSubview(downloadButton)
        //: backgroundImageView Constraints
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: backgroundImageView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: backgroundImageView)
        
        //: cancelButton Constraints
        view.addConstraintsWithFormat(format: "H:|-17-[v0(35)]", views: cancelButton)
        view.addConstraintsWithFormat(format: "V:|-21-[v0(35)]", views: cancelButton)
        
        //: downloadButton Constraints
        view.addConstraintsWithFormat(format: "H:|-18-[v0(35)]", views: downloadButton)
        view.addConstraintsWithFormat(format: "V:[v0(35)]-18-|", views: downloadButton)
    }
    
    //: Button actons
    func handleCancel() {
        UIView.animate(withDuration: 0.30, delay: 0, options: [.curveEaseOut], animations: {
            self.cancelButton.transform = CGAffineTransform(scaleX: 1.50, y: 1.50)
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    func handleDownload() {
        if !hasDownloadedImage {
            UIImageWriteToSavedPhotosAlbum(backgroundImageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            hasDownloadedImage = true
        }
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            hasDownloadedImage = false
        } else {
            //: We have a success
            let downloadedImage = #imageLiteral(resourceName: "Downloaded")
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn, animations: {
                self.downloadButton.transform = CGAffineTransform(scaleX: 0.50, y: 0.50)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                    self.downloadButton.transform = .identity
                    self.downloadButton.setImage(downloadedImage, for: .normal)
                }, completion: nil)
            })
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
