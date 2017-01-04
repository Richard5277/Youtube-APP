//
//  VideoCollectionCell.swift
//  Youtube
//
//  Created by Feihong Zhao on 2016-12-28.
//  Copyright © 2016 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit

class VideoCollectionCell: BaseCollectionCell {
    
    var video: Video? {
        didSet{
            
            if let thumbnailImageUrl = video?.thumbNailImageName{
                thumbnailImageView.loadImageWithUrlString(thumbnailImageUrl)
            }
            
            
            if let profileImageUrl = video?.channel?.profileImageName {
                userProfileImageView.loadImageWithUrlString(profileImageUrl)
            }
            
            titleLabel.text = video?.title
            if let channelName = video?.channel?.name, let numberofviews = video?.numberOfViews {
                
                //MARK: Getting the correct style of number
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                detailLabel.text = "\(channelName) • views: \(numberFormatter.string(from: numberofviews)!) • 2 years ago"
            }
            
            //MARK: measure title text
            if let title = video?.title{
                let size = CGSize(width: frame.width - 8 - 44 - 8 - 8, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimateRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                if estimateRect.size.height > 24 {
                    titleLabelHeightConstraint?.constant = 48
                }else{
                    titleLabelHeightConstraint?.constant = 24
                }
            }
            
        }
        
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        // Video Ratial 16:9
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 23
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    let detailLabel: UITextView = {
        let textView = UITextView()
        textView.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?

    override func setUpViews(){
        super.setUpViews()
        
        addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(self.bounds.width * 9/16)
            make.width.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
        }
        
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
        }
        
        addSubview(userProfileImageView)
        userProfileImageView.snp.makeConstraints { (make) in
            make.width.equalTo(46)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(8)
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(12)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userProfileImageView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
        }
        // Height Constraint for title label
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 24)
        titleLabelHeightConstraint?.isActive = true
        addConstraint(titleLabelHeightConstraint!)
        
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userProfileImageView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.equalTo(titleLabel.snp.bottom).offset(-2)
            make.height.equalTo(36)
        }
        
    }
   
}
