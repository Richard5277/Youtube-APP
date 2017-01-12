//
//  FeedCell.swift
//  Youtube
//
//  Created by Feihong Zhao on 2017-01-06.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit

class FeedCell: BaseCollectionCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    enum VideoFeedUrl: String {
        case home = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        case trending = "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json"
        case subscriptions = "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json"
    }
    
    let cellId = "cellId"
    var videos: [Video]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    func fetchVideosFromApiService(){
        
//        let homeVideosUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        ApiService.sharedInstance.fetchVideosForUrl(urlString: VideoFeedUrl.home.rawValue, completion: {(videos)in
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
    override func setUpViews() {
        
        super.setUpViews()
       
        fetchVideosFromApiService()
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        collectionView.register(VideoCollectionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 35, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let number = videos?.count {
            return number
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCollectionCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: height + 32 + 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.videos?[indexPath.row].title ?? "123")
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
    
}









