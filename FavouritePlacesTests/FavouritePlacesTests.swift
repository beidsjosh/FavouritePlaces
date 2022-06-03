//
//  FavouritePlacesTests.swift
//  FavouritePlacesTests
//
//  Created by Joshua Beidham on 3/5/2022.
//

import XCTest
@testable import FavouritePlaces

class FavouritePlacesTests: XCTestCase {
    
    var context = PersistenceController().container.viewContext
    func testPlace() throws {
        let newPlace = Place(context: context)
        let name = "New Place"
        let image = "https://kravmaganewcastle.com.au/wp-content/uploads/2017/04/default-image.jpg"
        let latitude = "0.0"
        let longitude = "0.0"
        let notes = "No Notes"
        newPlace.name = name
        newPlace.image = image
        newPlace.latitude = latitude
        newPlace.longitude = longitude
        newPlace.notes = notes
        XCTAssertEqual(newPlace.name, name)
        XCTAssertEqual(newPlace.image, image)
        XCTAssertEqual(newPlace.latitude, latitude)
        XCTAssertEqual(newPlace.longitude, longitude)
        XCTAssertEqual(newPlace.notes, notes)
    }

}
