//
//  ConstraintFormat.swift
//  Youtube
//
//  Created by Feihong Zhao on 2016-12-28.
//  Copyright © 2016 Feihong Zhao. All rights reserved.
//

import UIKit

// Adding Constraints
extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDectionary = [String: UIView]()
        for(index, view) in views.enumerated(){
            let key = "V\(index)"
            viewsDectionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDectionary))
    }
}

extension UICollectionViewCell {
    override open func addSubview(_ view: UIView) {
        super.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

struct MyColor {
    static var mainRed: UIColor = UIColor.rgb(red: 230, green: 32, blue: 31)
}

extension UIImage {
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}















