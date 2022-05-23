//
//  ImageResult.swift
//  BucketList
//
//  Created by Avishka Amunugama on 5/18/22.
//

import CoreLocation
import Foundation
import SwiftUI

struct ImageResult: Codable {
    let query: ImageQuery
}

struct ImageQuery: Codable {
    let pages: [Int: ImagePage]
}

struct PageImageURLInfo: Codable {
    let url: String
}

struct ImagePage: Codable, Comparable {

    let title: String
    let imageinfo:[PageImageURLInfo]?
     
    var pageImageURL: URL? {
        guard let url = imageinfo?.first?.url else {return nil}
        return URL(string: url)
    }
    
    static func < (lhs: ImagePage, rhs: ImagePage) -> Bool {
        lhs.title < rhs.title
    }
    
    static func == (lhs: ImagePage, rhs: ImagePage) -> Bool {
        lhs.title == rhs.title
    }
}
