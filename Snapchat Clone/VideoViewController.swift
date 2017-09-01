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
    private var isMuted = false
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
    let muteButton: UIButton = {
        let button = UIButton(type: .custom)
        let muteImage = UIImage(named: "Unmute")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .white
        button.setImage(muteImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleSound), for: .touchUpInside)
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
        //: TODO: Add image animation for when tapped
        if !hasDownloadedVideo {
            if !isMuted {
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path, self, #selector(video(videoPath:didFinishSavingWithError:contextInfo:)), nil)
            } else {
                //: Save the video without audio
                removeAudioFromVideo(videoURL.path)
            }
        }
    }
    func handleSound() {
        hasDownloadedVideo = false
        if !isMuted {
            isMuted = true
            self.player?.isMuted = true
            let muteImage = UIImage(named: "Mute")?.withRenderingMode(.alwaysTemplate)
            self.muteButton.setImage(muteImage, for: .normal)
        } else {
            isMuted = false
            self.player?.isMuted = false
            let unmuteImage = UIImage(named: "Unmute")?.withRenderingMode(.alwaysTemplate)
            self.muteButton.setImage(unmuteImage, for: .normal)
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
            hasDownloadedVideo = true
        }
        
    }
    
    func removeAudioFromVideo(_ videoPath: String) {
        let path: String = videoPath
        let mutableComposition = AVMutableComposition()
        let inputVideoPath: String = path
        let urlAsset = AVURLAsset(url: URL(fileURLWithPath: inputVideoPath), options: nil)
        //: Grab the composition video track from AVMutableComposition already made.
        let compositionVideoTrack: AVMutableCompositionTrack? = mutableComposition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: kCMPersistentTrackID_Invalid)
        //: Grab the source track from AVURLAsset
        let sourceVideoTrack: AVAssetTrack? = urlAsset.tracks(withMediaType: AVMediaTypeVideo)[0]
        let timeRange: CMTimeRange = CMTimeRangeMake(kCMTimeZero, urlAsset.duration)
        _ = try? compositionVideoTrack!.insertTimeRange(timeRange, of: sourceVideoTrack!, at: kCMTimeZero)
        //: Apply the original transform.
        if (sourceVideoTrack != nil) && (compositionVideoTrack != nil) {
            compositionVideoTrack!.preferredTransform = sourceVideoTrack!.preferredTransform
        }
        //: A new path is needed for the saved file. A unique file name (based upon the current date) will point to a file in the documents folder
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        let date = dateFormatter.string(from: Date())
        let savePath = (documentDirectory as NSString).appendingPathComponent("muteVideo-\(date).mov")
        let url = URL(fileURLWithPath: savePath)
        //: Create Exporter (render and export the merged video)
        guard let exportSession = AVAssetExportSession(asset: mutableComposition, presetName: AVAssetExportPresetHighestQuality) else { return }
        exportSession.outputURL = url
        exportSession.outputFileType = "com.apple.quicktime-movie"
        //: Perform the Export (Because the code performs the export asynchronously, this method returns immediately)
        exportSession.exportAsynchronously(completionHandler: {() -> Void in
            //: Save Final Video File
            let url = exportSession.outputURL!
            UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(self.video(videoPath:didFinishSavingWithError:contextInfo:)), nil)
        })
    }
    
    
    //: MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
        //: App moved to background
        NotificationCenter.default.addObserver(self, selector: #selector(applicationState), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        //: App is active
        NotificationCenter.default.addObserver(self, selector: #selector(applicationState), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
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
        view.addSubview(muteButton)
        //: cancelButton Constraints
        view.addConstraintsWithFormat(format: "H:|-17-[v0(35)]", views: cancelButton)
        view.addConstraintsWithFormat(format: "V:|-21-[v0(35)]", views: cancelButton)
        
        //: muteButton and downloadButton Constraints
        view.addConstraintsWithFormat(format: "H:|-18-[v0(35)]-20-[v1(35)]", views: muteButton, downloadButton)
        view.addConstraintsWithFormat(format: "V:[v0(35)]-18-|", views: downloadButton)
        view.addConstraintsWithFormat(format: "V:[v0(35)]-18-|", views: muteButton)
        
        
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
    //: MARK: - respond to Notifications
    func applicationState(notification: Notification) {
        if notification.name == .UIApplicationWillResignActive {
            print("App moved to background!")
            player?.pause()
        } else if notification.name == .UIApplicationDidBecomeActive {
            print("app is active!")
            player?.play()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
