//
//  CollectionViewCell.swift
//  Youtube
//
//  Created by Feihong Zhao on 2016-12-28.
//  Copyright © 2016 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit

class BaseCollectionCell: UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .clear
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
    }
}

