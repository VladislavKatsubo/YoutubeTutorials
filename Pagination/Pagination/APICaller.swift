//
//  APICaller.swift
//  Pagination
//
//  Created by Vlad Katsubo on 22.11.22.
//

import Foundation

class APICaller {
    public var isPaginating = false
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[String], Error>) -> Void) {
        if pagination {
            isPaginating = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 1.5), execute: {
            let originalData = [
                "Apple",
                "GoogLe",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Gooale",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Gooale",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Gooale",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Gooale",
                "Facebook"
            ]
            
            let newData = [
                "banana", "oranges", "grapes", "Food"
            ]
            
            completion(.success ( pagination ? newData : originalData ))
            if pagination {
                self.isPaginating = false
            }
        })
    }
}
