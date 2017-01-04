//
//  HomeController.swift
//  Youtube
//
//  Created by Feihong Zhao on 2016-12-28.
//  Copyright © 2016 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos = [Video]()
    
    let reusableCellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Fetching Dynamic Data from API
        fetchVideos()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCollectionCell.self, forCellWithReuseIdentifier: reusableCellId)
        collectionView?.alwaysBounceVertical = true
        collectionView?.contentInset = UIEdgeInsets(top: 55, left: 0, bottom: 8, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 55, left: 0, bottom: 8, right: 0)
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 8, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setUpMenuBar()
        setUpNavBarButtons()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellId, for: indexPath) as! VideoCollectionCell
        //MARK: Define the content inside the module, not in the controller, inside the controller, only pass the right datasource
        cell.video = videos[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16) * 9/16
        return CGSize(width: view.bounds.width, height: height + 16 + 48 + 36 + 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    let menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        return menuBar
    }()
    private func setUpMenuBar(){
        view.addSubview(menuBar)
        menuBar.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func setUpNavBarButtons(){
        let searchImage = UIImage().resizeImage(image: UIImage(named:"search")!, newWidth: 28).withRenderingMode(.alwaysOriginal)
        let searchButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage().resizeImage(image: UIImage(named:"more")!, newWidth: 28).withRenderingMode(.alwaysOriginal)
        let moreButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButtonItem,searchButtonItem]
    }
    func handleSearch(){
        print(123)
    }
    func handleMore(){
        print(456)
    }
    
    //MARK: fetch videos from dynamic json file
    func fetchVideos(){
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
                self.collectionView?.reloadData()
            }
//            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            print(str ?? "Videos Json Data")
        }.resume()
    }
}

