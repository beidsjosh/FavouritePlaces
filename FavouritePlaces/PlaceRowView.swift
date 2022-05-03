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
    
    var body: some View {
        Text(placesrow.name ?? "")
    }
}
