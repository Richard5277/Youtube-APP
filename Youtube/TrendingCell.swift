//
//  TrendingCell.swift
//  Youtube
//
//  Created by Zhao Feihong on 1/11/17.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideosFromApiService() {

//        let trendingVideosUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json"
        ApiService.sharedInstance.fetchVideosForUrl(urlString: VideoFeedUrl.trending.rawValue, completion: {(videos)in
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}
