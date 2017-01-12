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
//    var videos =  [Video]()
    
    //MARK: fetch videos from dynamic json file
    //MARK: Fetching Dynamic Data from API     
    
    func fetchVideosForUrl(urlString: String, completion: @escaping ([Video]) -> ()){
        // MARK: Cant use NSURL, has to be URL
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("Error when downloading json: \(error)")
                return
            }
            
            do {
                
                if let unwrappedData = data, let jsonDictionaires = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]] {
                    DispatchQueue.main.async {
                        //MARK: use map to loop through Array
                        completion(jsonDictionaires.map({ return Video(dictionary: $0) }))
                    }
                }
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()

    }
    
}
