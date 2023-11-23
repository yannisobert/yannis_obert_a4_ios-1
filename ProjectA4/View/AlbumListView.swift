//
//  AlbumListView.swift
//  ProjectA4
//
//  Created by Yannis Obert on 22/11/2023.
//

import SwiftUI

struct AlbumListView: View {
    @EnvironmentObject var sharedDataManager: SharedDataManager
    @State public var selectedAlbum: Album = Album(name: "test", band: "test", image: "test", creationDate: Date())
    @State public var selectedAlbumIndex: Int = 666
    @State public var isEditing = false

    var body: some View {
        List{
            ForEach(sharedDataManager.albumManager.selectableAlbums, id: \.self) { album in
                VStack {
                    if album.image == "" {
                        AsyncImage(url: URL(string: "https://caer.univ-amu.fr/wp-content/uploads/default-placeholder.png"), scale: 5)
                    } else {
                        AsyncImage(url: URL(string: album.image), scale: 5)
                    }
                    Text("\(album.name) by \(album.band)")
                    Text("Created the: \(album.creationDate)")
                    
                        Button(action: {
                            selectedAlbum = album
                            if let index = sharedDataManager.albumManager.selectableAlbums.firstIndex(of: album) {
                                selectedAlbumIndex = index
                            }
                            isEditing.toggle()
                        }) {
                            Image(systemName: "pencil")
                            .foregroundColor(.blue)
                        }
                    
                }
                Button(action: {
                    if let indexSecond = sharedDataManager.albumManager.selectableAlbums.firstIndex(of: album) {
                        sharedDataManager.albumManager.selectableAlbums.remove(at: indexSecond)
                        sharedDataManager.objectWillChange.send()
                    }
                    
                }) {
                    Image(systemName: "trash")
                    .foregroundColor(.red)
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            EditAlbumView(album: $selectedAlbum, index: $selectedAlbumIndex)
        }
        .onAppear{
            sharedDataManager.objectWillChange.send()
        }
    }
}
