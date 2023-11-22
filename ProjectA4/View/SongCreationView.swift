//
//  SongCreationView.swift
//  ProjectA4
//
//  Created by Yannis Obert on 22/11/2023.
//

import SwiftUI

struct SongCreationView: View {
    @EnvironmentObject var sharedDataManager: SharedDataManager

    @State public var songName = ""
    @StateObject public var albumManager = AlbumManager()
    @State public var selectedAlbum: Album = Album(name: "test", band: "test", image: "test", creationDate: Date())
    
    var body: some View {
            Form {
                Section(header: Text("Créer une chanson")) {
                    TextField("Nom de la musique", text: $songName)
                    Picker("Select an Album", selection: $selectedAlbum) {
                        Text("Aucun album").tag(-1)
                        ForEach(sharedDataManager.albumManager.selectableAlbums, id: \.self) { album in
                            Text(album.name).tag(album)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                Section {
                    Button(action: {
                        sharedDataManager.songManager.saveSong(songName: songName, albumID: selectedAlbum.id)
                    }) {
                        Text("Enregistrer la chanson")
                    }
                }
            }
            .onAppear{
                sharedDataManager.objectWillChange.send()
            }
            .navigationTitle("Créer une chanson")
        
    }
}
