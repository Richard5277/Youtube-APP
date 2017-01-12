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
    
    let homeCellId = "homeCellId"
    let trendingCellId = "trendingCellId"
    let subscriptionsCellId = "subscriptionsCellId"
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 8, height: self.view.frame.height))
        label.textColor = .white
        label.text = "  Home"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.homeController = self
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        return menuBar
    }()
    
    //MARK: setting menu is no-longer a view, its a object inside the HomController
    //MARK: Importance of 'lazy var'
    lazy var settingsLancher: SettingLauncher = {
        let settingsLauncher = SettingLauncher()
        settingsLauncher.homeController = self
        return settingsLauncher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMenuBar()
        setUpNavBarButtons()
        setUpCollectionView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var identifier: String = homeCellId
        
        
        if indexPath.item == 1 {
            identifier = trendingCellId
        } else if indexPath.item == 2 {
            identifier = subscriptionsCellId
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xValue = scrollView.contentOffset.x / 4
        menuBar.horizontalBarLeftConstraint?.constant = xValue
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //MARK: change the icon to right target
        let target = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = NSIndexPath(item: target, section: 0) as IndexPath
        
        setTitleForIndex(target)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init(rawValue: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    func setUpCollectionView(){
        //MARK: Change collectionView scroll direction to horizontal
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            //MARK: Reduce the gap between different cells
            flowLayout.minimumLineSpacing = 0
        }
        
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        //Seperate Different Cells to pages as a whole
        collectionView?.isPagingEnabled = true
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: homeCellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionsCellId)
    }
    
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
        print("Search")
    }
    
    private func setTitleForIndex(_ index: Int){
        //MARK: Wheneve You have to copy-past something, wrape them into a func
        self.titleLabel.text = "  \(titles[index])"
    }
    func scrollToMenuAtIndex(_ menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0) as IndexPath
        collectionView?.scrollToItem(at: indexPath, at: .init(rawValue: 0) , animated: true)
        setTitleForIndex(menuIndex)
    }
    
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

