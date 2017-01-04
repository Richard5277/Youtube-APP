//
//  Extensions.swift
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

//MARK: resizing image
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

//MARK: easy way to load image from URL
let imageCache = NSCache<AnyObject, AnyObject>()

//extension UIImageView {
//    
//    func loadImageWithUrlString(_ urlString: String){
//        
//        let url = URL(string: urlString)
//        image = nil
//        
//        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
//            self.image = imageFromCache
//        }
//        
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            if error != nil{
//                print("Error when downloading json: \(error)")
//                return
//            }
//            DispatchQueue.main.async {
//                
//                let imageToCache = UIImage(data: data!)
//                
//                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
//                
//                self.image = imageToCache
//            }
//            }.resume() //MARK: resume() is very important
//    }
//    
//}

class cumstomImageView: UIImageView {
    var imageUrlString: String?
    func loadImageWithUrlString(_ urlString: String){
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("Error when downloading json: \(error)")
                return
            }
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString{
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
            }.resume() //MARK: resume() is very important
    }

}
















