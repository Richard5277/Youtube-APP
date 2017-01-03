//
//  MenuCollectionCell.swift
//  Youtube
//
//  Created by Feihong Zhao on 2016-12-28.
//  Copyright © 2016 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit

class MenuCollectionCell: BaseCollectionCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "home")
        return imageView
    }()
    
    override func setUpViews() {
        super.setUpViews()
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(28)
            make.centerX.equalToSuperview()
            make.height.equalTo(28)
        }
    }
    
//    override var isHighlighted: Bool {
//        didSet{
//            imageView.tintColor = isHighlighted ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
//        }
//    }
    
    override var isSelected: Bool {
        didSet{
            imageView.tintColor = isSelected ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
}
