//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Feihong Zhao on 2017-01-04.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let iconName: String
    init(name: SettingName, iconName: String) {
        self.name = name
        self.iconName = iconName
    }
}

//MARK: using enumuration to avoid string value condition check
enum SettingName: String {
    case cancel = "Cancel"
    case setting = "Setting"
    case home = "Home"
    case terms = "Terms & Policies"
    case feedback = "Feedback"
    case help = "Help"
}

class SettingLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let settingCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let cellId = "cellId"

    let settings:[Setting] = {
        var settings = [Setting]()
        
        let settingCell = Setting(name: .setting, iconName: "setting")
        settings.append(settingCell)
        let homeCell = Setting(name: .home, iconName: "setting")
        settings.append(homeCell)
        let termsCell = Setting(name: .terms, iconName: "setting")
        settings.append(termsCell)
        let helpCell = Setting(name: .help, iconName: "setting")
        settings.append(helpCell)
        let feedbackCell = Setting(name: .feedback, iconName: "setting")
        settings.append(feedbackCell)
        let cancelCell = Setting(name: .cancel, iconName: "setting")
        settings.append(cancelCell)
        
        return settings
    }()
    
    let blackView = UIView()
    
    let height: CGFloat = 300 //MARK: cg for core graphic

    override init(){
        super.init()
        settingCollectionView.delegate = self
        settingCollectionView.dataSource = self
        settingCollectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    var homeController: HomeController?
    
    func showSettings(){
        //MARK: SHOW MENU
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSettings)))
            
            let yPosition = window.frame.height - height
            window.addSubview(settingCollectionView)
            settingCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.blackView.alpha = 1
                self.settingCollectionView.frame = CGRect(x: 0, y: yPosition, width: self.settingCollectionView.frame.width, height: self.settingCollectionView.frame.height)
            }, completion: nil)
        }
        
    }
    
    func dismissSettings(_ setting: Setting){
        
        //MARK: Show New View when Setting Menu Completely Dismissed
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.settingCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.settingCollectionView.frame.width, height: self.settingCollectionView.frame.height)
            }
        }) { (true) in
            //MARK: Never check the conditon of a string value !!!
            if setting.name != .cancel && setting.name.rawValue != ""  {
                self.homeController?.showDetailViewForSetting(setting)
            }
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 300 / CGFloat(settings.count)
        return CGSize(width: collectionView.frame.width, height: height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let setting = self.settings[indexPath.row]
       dismissSettings(setting)
    }
    
}







