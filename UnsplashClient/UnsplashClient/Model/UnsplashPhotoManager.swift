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
//extension UnsplashDataDelegate {
//    func updateUI(with photoModels: [PhotoModel], forID: Bool = false) {
//        updateUI(with: photoModels, forID: forID)
//    }
//}

struct UnsplashPhotoManager {
    
    let photoURL = "https://api.unsplash.com/photos"
    let photoSearchURL = "https://api.unsplash.com/search/photos"
    let random = "/random"
    let photoAPIKey = "/?client_id=\(apikey)"
    
    var delegate: UnsplashDataDelegate?
    
    func fetchPhotos() {
        let urlString = "\(photoURL)\(random)\(photoAPIKey)&count=50"
        performRequest(with: urlString, fromSearchBar: false)
    }
    
    func fetchPhotos(with query: inout String) {
        query = query.replacingOccurrences(of: " ", with: "%20")
        let urlString = "\(photoSearchURL)\(photoAPIKey)&query=\(query)"
        performRequest(with: urlString, fromSearchBar: true)
    }
    
    func getInfoForID(with id: String) {
        let urlString = "\(photoURL)/\(id)\(photoAPIKey)"
        performRequest(with: urlString, fromSearchBar: false, forID: true)
        return
    }
    
    func performRequest(with urlString: String, fromSearchBar: Bool, forID: Bool = false) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error?.localizedDescription ?? error!)
                    return
                }
                if let safeData = data {
                    if let photoData = self.parseJSON(safeData, ifSearch: fromSearchBar, getInfo: forID) {
                        self.delegate?.updateUI(with: photoData)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(_ unsplashData: Data, ifSearch: Bool = false, getInfo: Bool = false) -> [PhotoModel]? {
        let decoder = JSONDecoder()
        do {
            if ifSearch, !getInfo {
                let decodedData = try decoder.decode(UnsplashSearchData.self, from: unsplashData)
                var photoObjectsArray = [PhotoModel]()
                for photoObject in decodedData.results {
                    let id = photoObject.id
                    let authorName = photoObject.user.name
                    let dateCreated = photoObject.created_at
                    let regularPhoto = photoObject.urls.regular
                    let smallPhoto = photoObject.urls.small
                    let photoModel = PhotoModel()
                    photoModel.id = id
                    photoModel.authorName = authorName
                    photoModel.dateCreated = dateCreated
                    photoModel.regularPhoto = regularPhoto
                    photoModel.smallPhoto = smallPhoto
                    photoObjectsArray.append(photoModel)
                }
                return photoObjectsArray
            } else if !ifSearch, !getInfo {
                let decodedData = try decoder.decode([UnsplashData].self, from: unsplashData)
                var photoObjectsArray = [PhotoModel]()
                for photoObject in decodedData {
                    let id = photoObject.id
                    let authorName = photoObject.user.name
                    let dateCreated = photoObject.created_at
                    let regularPhoto = photoObject.urls.regular
                    let smallPhoto = photoObject.urls.small
                    let locationCity = photoObject.location.city
                    let locationCountry = photoObject.location.country
                    let location = PhotoLocation()
                    location.locationCity = locationCity
                    location.locationCountry = locationCountry
                    let downloads = photoObject.downloads
                    let photoModel = PhotoModel()
                    photoModel.id = id
                    photoModel.authorName = authorName
                    photoModel.dateCreated = dateCreated
                    photoModel.regularPhoto = regularPhoto
                    photoModel.smallPhoto = smallPhoto
                    photoModel.location = location
                    photoModel.downloads = downloads
                    photoObjectsArray.append(photoModel)
                }
                return photoObjectsArray
            } else if !ifSearch, getInfo {
                let decodedData = try decoder.decode(UnsplashData.self, from: unsplashData)
                var photoObjectsArray = [PhotoModel]()
                let id = decodedData.id
                let authorName = decodedData.user.name
                let dateCreated = decodedData.created_at
                let regularPhoto = decodedData.urls.regular
                let smallPhoto = decodedData.urls.small
                let locationCity = decodedData.location.city
                let locationCountry = decodedData.location.country
                let location = PhotoLocation()
                location.locationCity = locationCity
                location.locationCountry = locationCountry
                let downloads = decodedData.downloads
                let photoModel = PhotoModel()
                photoModel.id = id
                photoModel.authorName = authorName
                photoModel.dateCreated = dateCreated
                photoModel.regularPhoto = regularPhoto
                photoModel.smallPhoto = smallPhoto
                photoModel.location = location
                photoModel.downloads = downloads
                photoObjectsArray.append(photoModel)
                return photoObjectsArray
            }
        } catch {
            print("Error while parsing JSON:", error)
        }
        return nil
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
