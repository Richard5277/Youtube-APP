//
//  Video.swift
//  Youtube
//
//  Created by Feihong Zhao on 2016-12-29.
//  Copyright © 2016 Feihong Zhao. All rights reserved.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    //Reference type
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        //MARK: check if the value from json matches with the properties of the object, if not, return, ignore, if matches, do the setting
        
//        let targetString = key.replacingOccurrences(of: String(key[key.startIndex]), with: String(key[key.startIndex]).capitalized) //replace every charactor that matches with first charactor
        
//        let range = NSMakeRange(0, 1)
//        let selector = NSString(string: key).replacingCharacters(in: range, with: String(key.characters.first!).uppercased())
//        
        
        let selector = NSSelectorFromString("set\(key.capitalizingFirstLetter()):")
//        let selector = NSSelectorFromString("set\(key.capitalized):")
        let responds = self.responds(to: selector)
        
        if !responds {
            print("Data not find in Json or local: \(selector)")
            return
        }
        super.setValue(value, forKey: key)
    }
}

class Channel: SafeJsonObject {
    var name: String?
    var profile_image_name: String?
}

class Video: SafeJsonObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    var duration: NSNumber?
    
    var channel: Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        //MARK: Additional dictionaries in keyvalues
        if key == "channel" {
            //MARK: Dont fking use ? for self.channel =  Channel(), its gonna optional everything, and there would be no worning
            self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
//    override func setValuesForKeys(_ keyedValues: [String : Any]) {
//        
//        let uperCaseFirstCaractor = String(keyedValues.keys.first)
////        let range = keyedValues.keys.startIndex...keyedValues.startIndex.
////        let selectorString = keyedValues.keys.re
//        
//        let selector = NSSelectorFromString("setTitle")
//        let responds = self.responds(to: selector)
//        
//        
//        super.setValuesForKeys(keyedValues)
//        //MARK: Additional dictionaries in keyvalues
//        self.channel? = Channel()
//        self.channel?.setValuesForKeys(keyedValues["channel"] as! [String: AnyObject])
//    }

    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }

}

