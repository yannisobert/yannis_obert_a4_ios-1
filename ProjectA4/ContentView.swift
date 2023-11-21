//
//  ContentView.swift
//  ProjectA4
//
//  Created by Yannis Obert on 20/11/2023.
//

import SwiftUI

struct Album: Hashable {
    let id: UUID = UUID()
    var name: String
    var band: String
    var image: String
    var creationDate: Date
}

struct Song {
    var name: String
    var album: Album
}

struct ContentView: View {
    // Albums
    @State private var albumName = ""
    @State private var bandName = ""
    @State private var albumImage = ""
    @State private var albumCreationDate = Date()
    
    // Songs
    @State private var songName = ""
    @State private var selectedAlbum: UUID?

    @State private var selectableAlbums: [Album] = albums

    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Créer un album")){
                    TextField("Nom de l'album", text: $albumName)
                    TextField("Nom du groupe", text: $bandName)
                    TextField("Champ image", text: $albumImage)
                    DatePicker("Date de création", selection: $albumCreationDate, displayedComponents: .date)
                        }
                        
                Section {
                    Button(action: {
                        let newAlbum = Album(name: albumName, band: bandName, image: albumImage, creationDate: albumCreationDate)
                        
                        saveAlbum()
                        
                        print("Nouvel album créé: \(newAlbum)")
                    })
                    {
                        Text("Enregistrer l'album")
                    }
                }
            }
                    
            Form {
                Section(header: Text("Créer une chanson")) {
                    TextField("Nom de la musique", text: $songName)
                    Picker("Select an Album", selection: $selectedAlbum) {
                                 ForEach(albums, id: \.self) { album in
                                     Text(album.name).tag(album)
                                 }
                             }
                    .pickerStyle(WheelPickerStyle())
                }
                        
                Section {
                    Button(action: {
                        guard let selectedAlbum = selectedAlbum else {
                            print("Veuillez sélectionner un album")
                            return
                        }
                                
                        let newSong = Song(name: songName, album: albums.first(where: { $0.id == selectedAlbum }) ?? Album(name: "", band: "", image: "", creationDate: Date()))

                        
                        saveSong()
                        
                        print("Nouvelle chanson créée: \(newSong)")
                    }) {
                        Text("Enregistrer la chanson")
                    }
                }
            }
            List(albums, id: \.self) { album in
                Text("\(album.name) by \(album.name), create the \(album.creationDate.formatted())")
            }
        }
        .navigationTitle("Gestionnaire de musique")
    }
    
    
    
    func saveAlbum() {
        let newAlbum = Album(name: albumName, band: bandName, image: albumImage, creationDate: albumCreationDate)
        selectableAlbums.append(newAlbum)
        albums.append(newAlbum)
        
        albumName = ""
        bandName = ""
        albumImage = ""
        albumCreationDate = Date()
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
var albums = [
    Album(name: "Album 1", band: "Groupe 1", image: "image1", creationDate: Date()),
    Album(name: "Album 2", band: "Groupe 2", image: "image2", creationDate: Date())
]
func saveSong() {

}
