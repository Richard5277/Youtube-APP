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

    var videos: [Video] = {
        
        // Channel Options
        var lbChannel = Channel()
        lbChannel.name = "NBA Player LB.J"
        lbChannel.profileImageName = "lb"
        
        var taylorChannel = Channel()
        taylorChannel.name = "Taylor Swift"
        taylorChannel.profileImageName = "profile"
        
        // Video Options
        var videos = [Video]()
        
        var blankSpaceVideo = Video()
        blankSpaceVideo.title = "Taylor Swift - Blank Space - Recomended by Richard Zhao"
        blankSpaceVideo.thumbNailImageName = "video"
        blankSpaceVideo.numberOfViews = 343413341125623
        blankSpaceVideo.channel = lbChannel // Have to pass the whole object 
        videos.append(blankSpaceVideo)
        
        var redVideo = Video()
        redVideo.title = "Taylor Swift - Red"
        redVideo.thumbNailImageName = "red"
        redVideo.numberOfViews = 3351322344511
        redVideo.channel = taylorChannel
        videos.append(redVideo)
        
        return videos
    }()
    
    let reusableCellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
//        let video = videos[indexPath.row]
//        cell.video? = video
//        cell.thumbnailImageView.image = UIImage(named: (video.thumbNailImageName)!)
//        cell.titleLabel.text = video.title
//        cell.userProfileImageView.image = UIImage(named: (video.channel?.profileImageName)!)
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
}

