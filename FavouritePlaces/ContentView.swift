//
//  ContentView.swift
//  FavouritePlaces
//
//  Created by Joshua Beidham on 3/5/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    ///loads the persistence context for the Place Items
    @Environment(\.managedObjectContext) private var viewContext

    ///fetches the Places that are stored in CoreData
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.name, ascending: true)],
        animation: .default)
    private var places: FetchedResults<Place>

    var body: some View {
        NavigationView {
            List {
                ForEach(places) { place in
                    NavigationLink(destination: PlaceView(places: place)) {
                        PlaceRowView(placesrow: place)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }
    
    /// When the user clicks on the add button, this function is executed. Adds a Place item with default values that the user can edit later
    private func addItem() {
        withAnimation {
            let newPlace = Place(context: viewContext)
            newPlace.name = "New Place #\(places.count + 1)"
            newPlace.image = "https://kravmaganewcastle.com.au/wp-content/uploads/2017/04/default-image.jpg"
            newPlace.latitude = "0.0"
            newPlace.longitude = "0.0"
            newPlace.notes = "No Notes"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    ///deletes the item that the user has selected
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { places[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
