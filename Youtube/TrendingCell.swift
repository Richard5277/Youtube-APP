//
//  TrendingCell.swift
//  Youtube
//
//  Created by Zhao Feihong on 1/11/17.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
//    override var videos: [Video]? = [Video]()
    
    override func fetchVideosFromApiservice() {
        ApiService.sharedInstance.fetchVideosForTrending { (videos) in
            self.videos = [Video]()
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
