//
//  CoordinateRegionViewModel.swift
//  FavouritePlaces
//
//  Created by Joshua Beidham on 17/5/2022.
//

import Combine
import CoreLocation
import SwiftUI
import MapKit

class LocationViewModel: ObservableObject {
    ///Stores the coordinate strings
    @Published var location: CLLocation
    ///displays the map coordinates
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -27.47, longitude: 153.02), latitudinalMeters: 20000, longitudinalMeters: 20000)
    ///used to display the sunrise/sunset times
    @Published var sunriseSunset = SunriseSunset(sunrise: "unknown", sunset: "unknown")
    ///placeholder variable for the geocoding string
    @Published var name = ""
    var sunrise: String {
        get { sunriseSunset.sunrise }
        set { sunriseSunset.sunrise = newValue }
    }
    var sunset: String {
        get { sunriseSunset.sunset }
        set { sunriseSunset.sunset = newValue }
    }

    init(location: CLLocation) {
        self.location = location
    }

    ///used to display the Latitude value and update the value when the user drags across the map. Also used when the user performs geocoding
    var latitudeString: String {
        get { "\(region.center.latitude)" }
        set {
            guard let newLatitude = Double(newValue) else { return }
            let newLocation = CLLocation(latitude: newLatitude, longitude: region.center.longitude)
            let newLocationMap = CLLocationDegrees(newLatitude)
            location = newLocation
            region.center.latitude = newLocationMap
        }
    }
    ///used to display the Latitude value and update the value when the user drags across the map. Also used when the user performs geocoding
    var longitudeString: String {
        get { "\(region.center.longitude)" }
        set {
            guard let newLongitude = Double(newValue) else { return }
            let newLocation = CLLocation(latitude: region.center.latitude, longitude: newLongitude)
            let newLocationMap = CLLocationDegrees(newLongitude)
            location = newLocation
            region.center.longitude = newLocationMap
        }
    }

    ///function to lookup coordinates based on the place name the user inputs
    func lookupCoordinates(for place: String) {
        let coder = CLGeocoder()
        coder.geocodeAddressString(place) { optionalPlacemarks, optionalError in
            if let error = optionalError {
                print("Error looking up \(place): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
                print("Placemarks came back empty")
                return
            }
            let placemark = placemarks[0]
            guard let location = placemark.location else {
                print("Placemark has no location")
                return
            }
            self.location = location
            self.region.center = location.coordinate
        }
    }

    ///function to lookup the name of a place based on the coordinates inputted
    func lookupName(for location: CLLocation) {
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(location) { optionalPlacemarks, optionalError in
            if let error = optionalError {
                print("Error looking up \(location.coordinate): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
                print("Placemarks came back empty")
                return
            }
            let placemark = placemarks[0]
            for value in [
                \CLPlacemark.name,
                \.country,
                \.isoCountryCode,
                \.postalCode,
                \.administrativeArea,
                \.subAdministrativeArea,
                \.locality,
                \.subLocality,
                \.thoroughfare,
                \.subThoroughfare
            ] {
                print(String(describing: placemark[keyPath: value]))
            }
            self.name = placemark.subAdministrativeArea ?? placemark.locality ?? placemark.subLocality ?? placemark.name ?? placemark.thoroughfare ?? placemark.subThoroughfare ?? placemark.country ?? ""
        }
    }

    ///function to lookup the sunrise and sunset based on the coordinates currently inputted
    func lookupSunriseAndSunset() {
        let urlString = "https://api.sunrise-sunset.org/json?lat=\(latitudeString)&lng=\(longitudeString)"
        guard let url = URL(string: urlString) else {
            print("Malformed URL: \(urlString)")
            return
        }
        guard let jsonData = try? Data(contentsOf: url) else {
            print("Could not look up sunrise or sunset")
            return
        }
        guard let api = try? JSONDecoder().decode(SunriseSunsetAPI.self, from: jsonData) else {
            print("Could not decode JSON API:\n\(String(data: jsonData, encoding: .utf8) ?? "<empty>")")
            return
        }
        let inputFormatter = DateFormatter()
        inputFormatter.dateStyle = .none
        inputFormatter.timeStyle = .medium
        inputFormatter.timeZone = .init(secondsFromGMT: 0)
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .none
        outputFormatter.timeStyle = .medium
        outputFormatter.timeZone = .current
        var converted = api.results
        if let time = inputFormatter.date(from: api.results.sunrise) {
            converted.sunrise = outputFormatter.string(from: time)
        }
        if let time = inputFormatter.date(from: api.results.sunset) {
            converted.sunset = outputFormatter.string(from: time)
        }
        sunriseSunset = converted
    }
}



