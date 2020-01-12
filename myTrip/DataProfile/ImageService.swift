//
//  ImageService.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/13/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import Foundation
import Firebase

class ImageService {
    
    static let cache = NSCache<NSString, UIImage>()
    
    static func downloadImage(withURL url : URL, completion: @escaping (_ image: UIImage?) ->()) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, responseURL, error in
            var downloadImage: UIImage?
            
            if let data = data {
                downloadImage = UIImage(data: data)
            }
            
            if downloadImage != nil {
                cache.setObject(downloadImage!, forKey: url.absoluteString as NSString)
            }
            DispatchQueue.main.async {
                completion(downloadImage)
            }
        }
        dataTask.resume()
    }
    
    static func getImage(withURL url : URL, completion: @escaping (_ image: UIImage?) ->()) {
        if let image = cache.object(forKey: url.absoluteString as NSString ){
            completion(image)
        } else {
            downloadImage(withURL: url, completion: completion)
        }
    }
}
