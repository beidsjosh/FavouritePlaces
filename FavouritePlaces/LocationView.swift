//
//  LocationView.swift
//  FavouritePlaces
//
//  Created by Joshua Beidham on 17/5/2022.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @Binding var region: MKCoordinateRegion
    @ObservedObject var placesCoords: Place
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
            HStack {
                Text("Lat:")
                TextField("Enter Latitude", text: $region.latitudeString, onCommit: {
                    placesCoords.latitude = region.latitudeString
                })
            }
            HStack {
                Text("Lon:")
                TextField("Enter Longitude", text: $region.longitudeString, onCommit: {
                    placesCoords.longitude = region.longitudeString
                })
            }
        }
    }
}
