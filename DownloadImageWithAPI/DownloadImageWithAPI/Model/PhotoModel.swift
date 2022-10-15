//
//  PhotoModel.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 1.10.22.
//

import Foundation

struct PhotoModel {
    let authorName: String
    let likesAmount: Int
    let dateCreated: String
    let regularPhoto: String
    let smallPhoto: String
    let location: (String?, String?)
    let downloads: Int
}
