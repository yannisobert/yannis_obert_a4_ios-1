//
//  EditSongView.swift
//  ProjectA4
//
//  Created by Yannis Obert on 22/11/2023.
//

import SwiftUI

struct EditSongView: View {
    @Binding var song: Song
    @Binding var index: Int
    @EnvironmentObject var sharedDataManager: SharedDataManager
    
    @State private var updateAlbum: Album = Album(name: "test", band: "test", image: "test", creationDate: Date())
    
    @State private var isShowingAlert = false
    
    var body: some View {
        VStack {
            TextField("Enter song name", text: $song.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Picker("Select an Album", selection: $updateAlbum) {
                Text("Aucun album").tag(-1)
                ForEach(sharedDataManager.albumManager.selectableAlbums, id: \.self) { album in
                    Text(album.name).tag(album)
                }
            }
            .pickerStyle(WheelPickerStyle())
            Button("Save Changes") {
                song.albumID = updateAlbum.id
                if song.name != "" {
                    sharedDataManager.songManager.updateSong(index: index, song: song)
                } else {
                    isShowingAlert = true
                }
            }
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Erreur"), message: Text("Le nom de la chanson ne peut pas être vide"), dismissButton: .default(Text("OK")))
        }
        .navigationTitle("Edit Song")
    }
}
