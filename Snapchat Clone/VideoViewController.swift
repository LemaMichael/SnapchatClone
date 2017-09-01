//
//  VideoViewController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/31/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    private var hasDownloadedVideo = false
    private var videoURL: URL
    var player: AVPlayer?
    var playerController: AVPlayerViewController?
    
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    //: MARK: - button Actions
    func handleCancel() {
        UIView.animate(withDuration: 0.30, delay: 0, options: [.curveLinear], animations: {
            self.cancelButton.transform = CGAffineTransform(scaleX: 1.50, y: 1.50)
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    func handleDownload() {
        if !hasDownloadedVideo {
            UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path, self, #selector(video(videoPath:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    func video(videoPath: NSString, didFinishSavingWithError error: NSError?, contextInfo info: AnyObject) {
        if let error = error {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            present(alert, animated: true)
            hasDownloadedVideo = false
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
    
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
    }
    
    func setupViews() {
        //: AVPlayer setup
        player = AVPlayer(url: videoURL)
        playerController = AVPlayerViewController()
        guard player != nil && playerController != nil else {
            return
        }
        playerController!.showsPlaybackControls = false
        playerController!.player = player!
        self.addChildViewController(playerController!)
        self.view.addSubview(playerController!.view)
        playerController!.view.frame = view.frame
        
        view.addSubview(cancelButton)
        view.addSubview(downloadButton)
        //: cancelButton Constraints
        view.addConstraintsWithFormat(format: "H:|-17-[v0(35)]", views: cancelButton)
        view.addConstraintsWithFormat(format: "V:|-21-[v0(35)]", views: cancelButton)
        
        //: downloadButton Constraints
        view.addConstraintsWithFormat(format: "H:|-18-[v0(35)]", views: downloadButton)
        view.addConstraintsWithFormat(format: "V:[v0(35)]-18-|", views: downloadButton)
        
    }
    
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player!.seek(to: kCMTimeZero)
            self.player!.play()
        }
    }
    
    //: MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player?.play()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
