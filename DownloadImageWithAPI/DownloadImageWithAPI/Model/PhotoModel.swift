//
//  PhotoModel.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 1.10.22.
//

import Foundation

struct PhotoModel {
    let id: String
    let authorName: String
    let dateCreated: String
    let regularPhoto: String
    let smallPhoto: String
    var location: (String?, String?)
    var downloads: Int?
}

//struct SearchPhotoModel {
//    
//}
