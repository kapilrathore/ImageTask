//
//  ImageDownloadManager.swift
//  ImageTask
//
//  Created by Kapil Rathore on 14/05/18.
//  Copyright © 2018 Kapil Rathore. All rights reserved.
//

import UIKit

class ImageDownloadManager {
    
    // Singleton Class with a shared instance
    private init() {}
    static let shared = ImageDownloadManager()
    
    private let urlSession = URLSession(configuration: .default)
    typealias downloadCompletion = (UIImage?, URL?) -> Void
    
    // NSCache for image caching
    private let imageCache = NSCache<NSString, UIImage>()
    
    // for checking if a download task already exists corresponding to a given URL
    var tasks: [URL: URLSessionDataTask] = [:]
    
    // for fetching image for a given url with a completion handler -> (downloaded image,imageURL)
    func fetchImage(for imageUrl: String, completionHandler: @escaping downloadCompletion) {
        
        guard let downloadURL = URL(string: imageUrl) else {
            return completionHandler(nil, nil)
        }
        
        // if image found in cache return immidiately
        if let cachedImage = imageCache.object(forKey: imageUrl as NSString) {
            completionHandler(cachedImage, downloadURL)
        } else {
            
            // check if a task exists for a given URL
            if tasks.keys.contains(downloadURL) {
                // if found increase the priority of the task.
                tasks[downloadURL]?.priority = URLSessionTask.highPriority
            } else {
                // create a new data task for the image url.
                let dataTask = urlSession.dataTask(with: downloadURL) { [weak self] (data, response, error) in
                    
                    if error != nil { completionHandler(nil, downloadURL) }
                    
                    // after downloading, save the image in the cache and return in completionHandler
                    if let data = data, let image = UIImage(data: data) {
                        self?.imageCache.setObject(image, forKey: imageUrl as NSString)
                        completionHandler(image, downloadURL)
                    } else { completionHandler(nil, downloadURL) }
                }
                dataTask.resume()
                tasks[downloadURL] = dataTask
            }
        }
    }
}
