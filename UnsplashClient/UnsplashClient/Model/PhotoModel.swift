//
//  PhotoModel.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 1.10.22.
//

import Foundation
import RealmSwift

class PhotoModel: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var authorName: String = ""
    @Persisted var dateCreated: String = ""
    @Persisted var regularPhoto: String = ""
    @Persisted var smallPhoto: String = ""
    @Persisted var location: PhotoLocation?
    @Persisted var downloads: Int?
}

class PhotoLocation: Object {
    @Persisted var locationCity: String?
    @Persisted var locationCountry: String?
}
