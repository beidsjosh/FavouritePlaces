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
    @State var isEditMode: EditMode = .inactive
    
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
                if (self.isEditMode == .inactive) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                Text(places.name!)
                Text(places.latitude!)
                Text(places.longitude!)
                Text(places.notes!)
                } else {
                        TextField("Enter Image URL", text: .bindOptional($places.image, ""))
                        TextField("Enter place name", text: .bindOptional($places.name, ""))
                        TextField("Enter latitude", text: .bindOptional($places.latitude, ""))
                        TextField("Enter longitude", text: .bindOptional($places.longitude, ""))
                        TextField("Enter Notes", text: .bindOptional($places.notes, ""))
                    }
            }
            .navigationTitle(places.name ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .environment(\.editMode, self.$isEditMode)
    }
}
