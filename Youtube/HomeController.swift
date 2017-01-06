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
    
    func fetchVideos(){
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCollectionCell.self, forCellWithReuseIdentifier: reusableCellId)
        collectionView?.alwaysBounceVertical = true
        collectionView?.contentInset = UIEdgeInsets(top: 55, left: 0, bottom: 8, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 55, left: 0, bottom: 8, right: 0)
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 8, height: view.frame.height))
        titleLabel.text = "  Home"
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
        
        //MARK: Hide NavigationBar when Swiping
        navigationController?.hidesBarsOnSwipe = true
        let redView = UIView()
        redView.backgroundColor = MyColor.mainRed
        
        view.addSubview(redView)
        redView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalToSuperview()
        }
        
        view.addSubview(menuBar)
        menuBar.snp.makeConstraints { (make) in
//            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        //MARK: use topLayoutGuide to put content below the tatus bar
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
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
    
    //MARK: setting menu is no-longer a view, its a object inside the HomController
    //MARK: Importance of 'lazy var'
    lazy var settingsLancher: SettingLauncher = {
        let settingsLauncher = SettingLauncher()
        settingsLauncher.homeController = self
        return settingsLauncher
    }()
    
    func handleMore(){
        settingsLancher.showSettings()
    }
    
    func showDetailViewForSetting(_ setting: Setting){
        let detailViewController = UIViewController()
        detailViewController.title = setting.name.rawValue
        detailViewController.view.backgroundColor = .white
        navigationController?.pushViewController(detailViewController, animated: true)
        
        //MARK: Change navigation stack title color
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
}

