//
//  VideoLauncher.swift
//  Youtube
//
//  Created by Feihong Zhao on 2017-01-12.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.tintColor = .white
        let img = UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate)
        bt.setImage(img, for: .normal)
        bt.isHidden = true
        
        bt.addTarget(self, action: #selector(pauseAndPlayVideo), for: .touchUpInside)
        
        return bt
    }()
    
    let controlContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUpPlayerView()
        controlContainerView.frame = frame
        addSubview(controlContainerView)
        controlContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        controlContainerView.addSubview(pausePlayButton)
        pausePlayButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var player: AVPlayer?
    var isVideoPlaying: Bool?
    
    private func setUpPlayerView(){
        let urlString = "https://firebasestorage.googleapis.com/v0/b/routine-77602.appspot.com/o/message_videos%2F1F13D18C-36B3-4AEC-8D7B-4BA77288D421.mov?alt=media&token=6a208334-5157-4b19-a0d5-d079745b4e58"
        if let url = NSURL(string: urlString) {
            self.player = AVPlayer(url: url as URL)
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            isVideoPlaying = true
        }
    }
    
    //MARK: checking for the status change of video player
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            pausePlayButton.isHidden = false
            activityIndicatorView.stopAnimating()
            controlContainerView.backgroundColor = .clear
            
        }
    }
    
    func pauseAndPlayVideo(){
        
        if isVideoPlaying! {
            player?.pause()
            self.pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
            isVideoPlaying = false
        } else {
            player?.play()
            self.pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
            isVideoPlaying = true
        }
    }
    
}



class VideoLauncher: NSObject {
    
    func showVideoPlayer(){
        if let keyWindow = UIApplication.shared.keyWindow {
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .white
            backgroundView.frame = CGRect(x: keyWindow.frame.width, y: keyWindow.frame.height, width: 0, height: 0)
            
            let videoPlayerHeight = keyWindow.frame.width * 9 / 16
            let videoPlayerViewFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: videoPlayerHeight)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerViewFrame)
            backgroundView.addSubview(videoPlayerView)
            
            keyWindow.addSubview(backgroundView)
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
 
                backgroundView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: keyWindow.frame.height)
            }, completion: { (completion) in
                UIApplication.shared.isStatusBarHidden = true
            })
            
        }
    }
    
    
    
}
