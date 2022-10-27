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
    var created_at: String
    var user: User
    var location: Location
    var downloads: Int
}

struct URLs: Codable {
    var regular: String
    var thumb: String
    var small: String
}

struct User: Codable {
    var name: String
}
struct Location: Codable {
    var name: String?
    var city: String?
    var country: String?
}

//MARK: - Structs to parse json for search query (it's slightly different).

struct UnsplashSearchData: Codable {
    var results: [Results]
}

struct Results: Codable {
    var id: String
    var created_at: String
    var urls: URLs
    var user: User
    var likes: Int
}


