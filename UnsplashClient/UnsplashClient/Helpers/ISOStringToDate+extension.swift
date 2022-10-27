//
//  StringToDate+extension.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 11.10.22.
//

import Foundation
import UIKit

extension String {
    var formatToDate: String? {
        let dateString = self
        let dateFormatter = ISO8601DateFormatter()
        let isoDateToString = dateFormatter.date(from: dateString)
        dateFormatter.formatOptions = [.withFullDate, .withFullTime]
        if let isoDateToString = isoDateToString {
            let dateToReturn = String(DateFormatter.localizedString(from: isoDateToString, dateStyle: .medium, timeStyle: .none))
            return dateToReturn
        }
        return nil
    }
}
