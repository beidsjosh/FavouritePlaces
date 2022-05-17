//
//  PlaceView.swift
//  FavouritePlaces
//
//  Created by Joshua Beidham on 3/5/2022.
//

import SwiftUI
import MapKit

struct PlaceView: View {
    @ObservedObject var places: Place
    @Environment(\.managedObjectContext) var viewContext
    @State var isEditMode: EditMode = .inactive
    @State private var region2 = MKCoordinateRegion(.world)
    
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
                    NavigationLink {
                        LocationView(region: $region2, placesCoords: places)
                    } label: {
                        Text("Location")
                    }
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
        if (self.isEditMode == .active) {
        Button {
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
                } label: {
                    Text("Save Changes")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 40)
                        .background(Color.green)
                        .cornerRadius(15)
                        .padding()
                }
        }
    }
}
