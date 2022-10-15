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
    let photoSearchURL = "https://api.unsplash.com/search/photos"
    let photoRandomMethod = "/random"
    let photoAPIKey = "/?client_id=\(apikey)"
    
    var delegate: UnsplashDataDelegate?
    
    func fetchPhotos() {
        let urlString = "\(photoURL)\(photoRandomMethod)\(photoAPIKey)&count=10"
        performRequest(with: urlString, ifSearch: false)
    }
    
    func fetchPhotos(with query: inout String) {
        query = query.replacingOccurrences(of: " ", with: "%20")
        let urlString = "\(photoSearchURL)\(photoAPIKey)&query=\(query)"
        
        print(urlString)
        performRequest(with: urlString, ifSearch: true)
    }
    
    func performRequest(with urlString: String, ifSearch: Bool) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error?.localizedDescription ?? error!)
                    return
                }
                
                if let safeData = data {
                    if let photoData = self.parseJSON(safeData, ifSearch: ifSearch) {
                        self.delegate?.updateUI(with: photoData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ unsplashData: Data, ifSearch: Bool = false) -> [PhotoModel]? {
        let decoder = JSONDecoder()
        do {
            if ifSearch {
                let decodedData = try decoder.decode(UnsplashSearchData.self, from: unsplashData)
                var photoObjectsArray = [PhotoModel]()
                print(decodedData)
                for photoObject in decodedData.results {
                    let authorName = photoObject.user.name
                    let likesAmount = photoObject.likes
                    let dateCreated = photoObject.created_at
                    let regularPhoto = photoObject.urls.regular
                    let smallPhoto = photoObject.urls.small
                    let downloads = photoObject.downloads
                    //                    let location =
                    let photoModel = PhotoModel(authorName: authorName, likesAmount: likesAmount, dateCreated: dateCreated, regularPhoto: regularPhoto, smallPhoto: smallPhoto, location: ("", ""), downloads: downloads)
                    photoObjectsArray.append(photoModel)
                    print("Here is your data", photoModel)
                }
                return photoObjectsArray
            } else {
                let decodedData = try decoder.decode([UnsplashData].self, from: unsplashData)
                var photoObjectsArray = [PhotoModel]()
                for photoObject in decodedData {
                    let authorName = photoObject.user.name
                    let likesAmount = photoObject.likes
                    let dateCreated = photoObject.created_at
                    let regularPhoto = photoObject.urls.regular
                    let smallPhoto = photoObject.urls.small
                    let locationCity = photoObject.location.city
                    let locationCountry = photoObject.location.country
                    let downloads = photoObject.downloads
                    let photoModel = PhotoModel(authorName: authorName, likesAmount: likesAmount, dateCreated: dateCreated, regularPhoto: regularPhoto, smallPhoto: smallPhoto, location: (locationCity, locationCountry), downloads: downloads)
                    photoObjectsArray.append(photoModel)
                    //                locationCity: locationCity, locationCountry: locationCountry,
                }
                return photoObjectsArray
            }
            
        } catch {
            print("Error while parsing JSON:", error)
            return nil
        }
    }
    
}


//MARK: - Class for UIImageView to load image from URL and cache it
let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    let activityView = UIActivityIndicatorView(style: .large)
    var imageUrlString: String?
    
    func loadImageFromURL(_ urlString: String) {
        
        
        imageUrlString = urlString
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        activityView.frame = frame
        activityView.center = center
        addSubview(activityView)
        activityView.startAnimating()
        
        
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            activityView.stopAnimating()
            activityView.removeFromSuperview()
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.activityView.stopAnimating()
                self.activityView.removeFromSuperview()
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
