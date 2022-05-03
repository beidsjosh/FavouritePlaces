//
//  PlaceView.swift
//  FavouritePlaces
//
//  Created by Joshua Beidham on 3/5/2022.
//

import SwiftUI

struct PlaceView: View {
    @ObservedObject var places: Place
    @Environment(\.managedObjectContext) var viewContext
    
    var image: UIImage {
        guard
            let url = URL(string: places.image!),
            let data = try? Data(contentsOf: url)
        else {
            fatalError("Something went wrong!")
        }
        return UIImage(data: data)!
    }
    
    var body: some View {
            List {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                Text(places.name!)
                Text("\(places.latitude, specifier: "%.1f")")
                Text("\(places.longitude, specifier: "%.2f")")
                Text(places.notes!)
            }
        .navigationTitle(places.name!)
    }
}
