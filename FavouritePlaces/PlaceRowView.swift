//
//  PlaceRowView.swift
//  FavouritePlaces
//
//  Created by Joshua Beidham on 3/5/2022.
//

import SwiftUI

struct PlaceRowView: View {
    ///loads the Place Item from PlaceView
    @ObservedObject var placesrow: Place
    ///loads the persistence context
    @Environment(\.managedObjectContext) var viewContext
    
    ///loads the image
    var image: UIImage {
        guard
            let url = URL(string: placesrow.image ?? "https://kravmaganewcastle.com.au/wp-content/uploads/2017/04/default-image.jpg"),
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
