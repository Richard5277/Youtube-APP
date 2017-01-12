//
//  SubscriptionCell.swift
//  Youtube
//
//  Created by Feihong Zhao on 2017-01-11.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideosFromApiService() {
        ApiService.sharedInstance.fetchVideosForUrl(urlString: VideoFeedUrl.subscriptions.rawValue, completion: {(videos)in
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })

    }
}
