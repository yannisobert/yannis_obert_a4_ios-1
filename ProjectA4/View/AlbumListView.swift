//
//  AlbumListView.swift
//  ProjectA4
//
//  Created by Yannis Obert on 22/11/2023.
//

import SwiftUI

struct AlbumListView: View {
    @EnvironmentObject var sharedDataManager: SharedDataManager

    var body: some View {
        List{
            ForEach(sharedDataManager.albumManager.selectableAlbums, id: \.self) { album in
                if album.image == "" {
                    AsyncImage(url: URL(string: "https://caer.univ-amu.fr/wp-content/uploads/default-placeholder.png"), scale: 5)
                } else {
                    AsyncImage(url: URL(string: album.image), scale: 5)
                }
                Text("\(album.name) by \(album.band)")
                Button(action: {
                    if let index = sharedDataManager.albumManager.albums.firstIndex(of: album) {
                        print("HERE")
                        sharedDataManager.albumManager.selectableAlbums.remove(at: index)
                        sharedDataManager.objectWillChange.send()
                    }
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear{
            sharedDataManager.objectWillChange.send()
        }
    }
}
