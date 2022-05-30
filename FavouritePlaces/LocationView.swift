//
//  LocationView.swift
//  FavouritePlaces
//
//  Created by Joshua Beidham on 17/5/2022.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @ObservedObject var placesCoords: Place
    @ObservedObject var locationModel: LocationViewModel
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    print("Looking up \(locationModel.location.coordinate)")
                    locationModel.lookupName(for: locationModel.location)
                } label: {
                    Label("Name:", systemImage: "text.magnifyingglass")
                }
                TextField("Enter name", text: $locationModel.name) {
                    print("Looking up \(locationModel.name)")
                    locationModel.lookupCoordinates(for: locationModel.name)
                }
            }
            HStack {
                Text("Latitude:").font(.headline)
                TextField("Enter coordinate", text: $locationModel.latitudeString)
            }
            HStack {
                Text("Longitude:").font(.headline)
                TextField("Enter coordinate", text: $locationModel.longitudeString)
            }
            Button("Look up sunrise and sunset") {
                locationModel.lookupSunriseAndSunset()
            }
            HStack {
                Label(locationModel.sunrise, systemImage: "sunrise")
                Spacer()
                Label(locationModel.sunset,  systemImage: "sunset")
            }.padding()
        }.padding()
    }
}
