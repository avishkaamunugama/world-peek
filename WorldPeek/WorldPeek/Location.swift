//
//  Location.swift
//  BucketList
//
//  Created by Avishka Amunugama on 5/18/22.
//

import CoreLocation
import Foundation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var cllLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), latitude: 35.689506, longitude: 139.691700)
}
