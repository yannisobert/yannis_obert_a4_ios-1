//
//  ContentView.swift
//  ProjectA4
//
//  Created by Yannis Obert on 20/11/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var albumName = ""
    @State private var bandName = ""
    @State private var albumImage = ""
    @State private var albumCreationDate = Date()

    @State private var songName = ""
    
    @StateObject private var albumManager = AlbumManager()
    @State private var songManager = SongManager()
    
    @State private var selectedAlbum: Album? = Album(name: "test", band: "test", image: "test", creationDate: Date())

    
    var body: some View {
        TabView {
            // Première page pour créer un album
            NavigationView {
                Form {
                    Section(header: Text("Créer un album")) {
                        TextField("Nom de l'album", text: $albumName)
                        TextField("Nom du groupe", text: $bandName)
                        TextField("Champ image", text: $albumImage)
                        DatePicker("Date de création", selection: $albumCreationDate, displayedComponents: .date)
                    }

                    Section {
                        Button(action: {
                            albumManager.saveAlbum(albumName: albumName, bandName: bandName, albumImage: albumImage, albumCreationDate: albumCreationDate)
                        }) {
                            Text("Enregistrer l'album")
                        }
                    }
                }
                .navigationTitle("Créer un album")
            }
            .tabItem {
                Label("Album", systemImage: "square.and.pencil")
            }
            .tag(0)

            // Deuxième page pour créer une chanson
            NavigationView {
                Form {
                    Section(header: Text("Créer une chanson")) {
                        TextField("Nom de la musique", text: $songName)
                            Picker("Select an Album", selection: $selectedAlbum) {
                                ForEach(albumManager.selectableAlbums, id: \.id) { album in
                                    Text(album.name).tag(album.id)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }

                    Section {
                        Button(action: {
                            guard let selectedAlbumID = selectedAlbum?.id else {
                                print("Veuillez sélectionner un album.")
                                return
                            }
                            print(selectedAlbumID)
                                songManager.saveSong(songName: songName, albumID: selectedAlbumID)
                            }) {
                                Text("Enregistrer la chanson")
                            }  
                    }
                }
                .navigationTitle("Créer une chanson")
            }
            .tabItem {
                Label("Chanson", systemImage: "music.note.list")
            }
            .tag(1)
            NavigationView {
                List(albumManager.selectableAlbums, id: \.self) { album in
                    AsyncImage(url: URL(string: album.image), scale: 5)
                    Text("\(album.name) by \(album.name), create the \(album.creationDate.formatted())")
                }
            }
            .tabItem {
                Label("Tous les albums", systemImage: "music.note")
            }
            .tag(2)
            NavigationView {
                List(songManager.songs, id: \.self) { song in
                    Text("\(song.name) (Album non trouvé, ID: \(song.albumID))")

                }
                .navigationTitle("Toutes les chansons")
            }
            .tabItem {
                Label("Tous les musiques", systemImage: "music.note")
            }
            .tag(3)
        }
        .onAppear {
        }
        .navigationTitle("Gestionnaire de musique")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
