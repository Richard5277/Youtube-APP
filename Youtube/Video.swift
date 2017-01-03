//
//  Video.swift
//  Youtube
//
//  Created by Feihong Zhao on 2016-12-29.
//  Copyright © 2016 Feihong Zhao. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbNailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
