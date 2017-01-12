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
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        let urlString = "https://firebasestorage.googleapis.com/v0/b/routine-77602.appspot.com/o/message_videos%2F1F13D18C-36B3-4AEC-8D7B-4BA77288D421.mov?alt=media&token=6a208334-5157-4b19-a0d5-d079745b4e58"
        if let url = NSURL(string: urlString) {
            let player = AVPlayer(url: url as URL)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player.play()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
