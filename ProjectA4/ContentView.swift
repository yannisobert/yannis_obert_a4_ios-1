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
    
    @State var selectedAlbum: Album = Album(name: "test", band: "test", image: "test", creationDate: Date())

    
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
                                Text("Aucun album").tag(-1)
                                ForEach(albumManager.selectableAlbums, id: \.self) { album in
                                    Text(album.name).tag(album)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }

                    Section {
                        Button(action: {
                            print(selectedAlbum.name)
                            songManager.saveSong(songName: songName, albumID: selectedAlbum.id)
                        }) {
                            Text("Enregistrer l'album")
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
                    VStack {
                        if album.image == "" {
                            AsyncImage(url: URL(string: "https://caer.univ-amu.fr/wp-content/uploads/default-placeholder.png"), scale: 5)
                        } else {
                            AsyncImage(url: URL(string: album.image), scale: 5)
                        }
                    Text("\(album.name) by \(album.band)")
                    }
                }

            }
            .tabItem {
                Label("Tous les albums", systemImage: "music.note")
            }
            .tag(2)
            NavigationView {
                List(songManager.songs, id: \.self) { song in
                    if let songAlbum = albumManager.albums.first(where: { $0.id == song.albumID }) {
                        Text("\(song.name) in \(songAlbum.name)")
                    } else {
                        Text("Aucune entité correspondante trouvée. (UUID: \(song.albumID)")
                    }
                }
                .navigationTitle("Toutes les chansons")
            }
            .tabItem {
                Label("Tous les musiques", systemImage: "music.note")
            }
            .tag(3)
            
            NavigationView {
                Text("Top 10 Billboard")
            }
            .tabItem {
                Label("Tous les musiques", systemImage: "music.note")
            }
            .tag(4)
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
