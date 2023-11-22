//
//  ContentView.swift
//  ProjectA4
//
//  Created by Yannis Obert on 20/11/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var sharedDataManager = SharedDataManager()

    var body: some View {
        TabView {
            AlbumCreationView()
                .environmentObject(sharedDataManager)
                .tabItem {
                    Label("Album", systemImage: "square.and.pencil")
                }
                .tag(0)

            SongCreationView()
                .environmentObject(sharedDataManager)
                .tabItem {
                    Label("Chanson", systemImage: "music.note.list")
                }
                .tag(1)

            AlbumListView()
                .environmentObject(sharedDataManager)
                .tabItem {
                    Label("Tous les albums", systemImage: "music.note")
                }
                .tag(2)

            SongListView()
                .environmentObject(sharedDataManager)
                .tabItem {
                    Label("Tous les musiques", systemImage: "music.note")
                }
                .tag(3)

            Top10BillboardView()
                .tabItem {
                    Label("Top 10 Billboard", systemImage: "music.note")
                }
                .tag(4)
        }
        .navigationTitle("Gestionnaire de musique")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
