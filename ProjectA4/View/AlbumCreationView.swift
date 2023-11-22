//
//  AlbumCreationView.swift
//  ProjectA4
//
//  Created by Yannis Obert on 22/11/2023.
//

import SwiftUI

struct AlbumCreationView: View {
    @EnvironmentObject var sharedDataManager: SharedDataManager

    @State private var albumName = ""
    @State private var bandName = ""
    @State private var albumImage = ""
    @State private var albumCreationDate = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Créer un album")) {
                    TextField("Nom de l'album", text: $albumName)
                    TextField("Nom du groupe", text: $bandName)
                    TextField("Champ image", text: $albumImage)
                    DatePicker("Date de création", selection: $albumCreationDate, displayedComponents: .date)
                }
                
                Section {
                    // Use albumManager and save functionality here
                    Button(action: {
                        sharedDataManager.albumManager.saveAlbum(albumName: albumName, bandName: bandName, albumImage: albumImage, albumCreationDate: albumCreationDate)
                    }) {
                        Text("Enregistrer l'album")
                    }
                }
            }
            .navigationTitle("Créer un album")
        }
    }
}
