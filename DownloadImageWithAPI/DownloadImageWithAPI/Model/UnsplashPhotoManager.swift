//
//  UnsplashPhotoManager.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 30.09.22.
//

import Foundation
import UIKit

protocol UnsplashDataDelegate {
    func updateUI(with photoModels: [PhotoModel])
}

struct UnsplashPhotoManager {
    
    let photoURL = "https://api.unsplash.com/photos"
    let photoRandomMethod = "/random"
    let photoAPIKey = "/?client_id=\(apikey)"
    
    var delegate: UnsplashDataDelegate?
    
    func fetchPhotos() {
        let urlString = "\(photoURL)\(photoRandomMethod)\(photoAPIKey)&count=10"
        performRequest(with: urlString)
    }
    
    func fetchPhotos(with query: String) {
        let urlString = "\(photoURL)\(photoAPIKey)&q=\(query)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    //                    delegate?.didFailWithError(error: error!)
                    print(error?.localizedDescription ?? error!)
                    return
                }
                
                if let safeData = data {
                    if let photoData = self.parseJSON(safeData) {
                        self.delegate?.updateUI(with: photoData)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ unsplashData: Data) -> [PhotoModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([UnsplashData].self, from: unsplashData)
            var photoObjectsArray = [PhotoModel]()
            for photoObject in decodedData {
                let authorName = photoObject.user.name
                let likesAmount = photoObject.likes
                let dateCreated = photoObject.created_at
                let regularPhoto = photoObject.urls.regular
                let location = photoObject.user.location
                let photoModel = PhotoModel(authorName: authorName, likesAmount: likesAmount, dateCreated: dateCreated, regularPhoto: regularPhoto, location: location)
                photoObjectsArray.append(photoModel)
            }
            return photoObjectsArray
        } catch {
            print("Error while parsing JSON:", error.localizedDescription)
            return nil
        }
    }
    
}


//MARK: - Extension for UIImageView to load image from URL and cache it
let imageCache = NSCache<AnyObject, AnyObject>()
let activityView = UIActivityIndicatorView(style: .medium)
class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageFromURL(_ urlString: String) {
        imageUrlString = urlString
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        activityView.center = self.center
        self.addSubview(activityView)
        activityView.startAnimating()
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityView.stopAnimating()
            activityView.removeFromSuperview()
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                activityView.stopAnimating()
                activityView.removeFromSuperview()
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: data) {
                        if self.imageUrlString == urlString {
                            self.image = imageToCache
                        }
                        imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    } else {
                        print(error?.localizedDescription ?? "Can't load image from URL")
                    }
                }
            }
        }.resume()
        
    }
}
