//
//  PlaceView.swift
//  FavouritePlaces
//
//  Created by Joshua Beidham on 3/5/2022.
//

import SwiftUI
import MapKit

struct PlaceView: View {
    ///loads the object Place from ContentView
    @ObservedObject var places: Place
    ///loads the persistence context
    @Environment(\.managedObjectContext) var viewContext
    ///used to tell if edit mode is on or off
    @State var isEditMode: EditMode = .inactive
    ///default coordinates to pass into LocationView
    @StateObject var coordinates = LocationViewModel(location: CLLocation(latitude: -27.47, longitude: 153.02))
    
    ///loads the image
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
        //if edit mode is active, displays textfields instead of image and Location button
            List {
                if (self.isEditMode == .inactive) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                Text(places.name!)
                    NavigationLink {
                        LocationView(placesCoords: places, locationModel: coordinates)
                    } label: {
                        Text("Location")
                    }
                Text(places.notes!)
                } else {
                    TextField("Enter Image URL", text: .bindOptional($places.image, ""))
                    TextField("Enter place name", text: .bindOptional($places.name, ""))
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
        //displays save button when edit mode is active
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
