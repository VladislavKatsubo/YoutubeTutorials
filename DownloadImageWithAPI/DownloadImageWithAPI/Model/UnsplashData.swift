//
//  UnsplashPhoto.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 29.09.22.
//

import Foundation

struct UnsplashData: Codable, Identifiable {
    var id: String
    var urls: URLs
    var likes: Int
    var created_at: String
    var user: User
}

struct URLs: Codable {
    var regular: String
    var thumb: String
}

struct User: Codable {
    var name: String
    var location: String?
}
