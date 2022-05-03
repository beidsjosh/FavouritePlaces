//
//  Place+CoreDataProperties.swift
//  FavouritePlaces
//
//  Created by Joshua Beidham on 3/5/2022.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var latitude: Double
    @NSManaged public var notes: String?
    @NSManaged public var longitude: Double

}

extension Place : Identifiable {

}
