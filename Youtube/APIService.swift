//
//  APIService.swift
//  Youtube
//
//  Created by Feihong Zhao on 2017-01-05.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    var videos = [Video]()
    
    //MARK: fetch videos from dynamic json file
    //MARK: Fetching Dynamic Data from API     
    func fetchVideos(completion: @escaping ([Video]) -> ()){
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("Error when downloading json: \(error)")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                    //transport video data
                    let newVideo = Video()
                    newVideo.title = dictionary["title"] as? String
                    newVideo.thumbNailImageName = dictionary["thumbnail_image_name"] as? String
                    newVideo.numberOfViews = dictionary["number_of_views"] as? NSNumber
                    
                    //transport channel data
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    newVideo.channel = channel
                    self.videos.append(newVideo)
                }
            } catch let jsonError {
                print(jsonError)
            }
            DispatchQueue.main.async {
                
                completion(self.videos)
                
            }
            }.resume()
    }
}
