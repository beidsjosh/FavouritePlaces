//
//  CoordinateRegionViewModel.swift
//  FavouritePlaces
//
//  Created by Joshua Beidham on 17/5/2022.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    var latitudeString: String {
        get { "\(center.latitude)" }
        set {
            guard let degrees = CLLocationDegrees(newValue) else {
                return }
            center.latitude = degrees
        }
    }
    var longitudeString: String {
        get {"\(center.longitude)"}
        set {
            guard let degrees = CLLocationDegrees(newValue) else {
                return }
            center.longitude = degrees
        }
    }
}
