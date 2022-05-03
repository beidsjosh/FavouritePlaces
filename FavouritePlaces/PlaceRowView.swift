//
//  PlaceRowView.swift
//  FavouritePlaces
//
//  Created by Joshua Beidham on 3/5/2022.
//

import SwiftUI

struct PlaceRowView: View {
    @ObservedObject var placesrow: Place
    @Environment(\.managedObjectContext) var viewContext
    
    var image: UIImage {
        guard
            let url = URL(string: placesrow.image!),
            let data = try? Data(contentsOf: url)
        else {
            fatalError("Something went wrong!")
        }
        return UIImage(data: data)!
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
        Text(placesrow.name ?? "")
    }
}
