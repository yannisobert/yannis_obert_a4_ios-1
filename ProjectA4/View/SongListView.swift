//
//  SongListView.swift
//  ProjectA4
//
//  Created by Yannis Obert on 22/11/2023.
//

import SwiftUI

struct SongListView: View {
    @EnvironmentObject var sharedDataManager: SharedDataManager

    @State private var songManager = SongManager()
    @StateObject private var albumManager = AlbumManager()
    
    var body: some View {
        List(sharedDataManager.songManager.songs, id: \.self) { song in
            if let songAlbum = sharedDataManager.albumManager.albums.first(where: { $0.id == song.albumID }) {
                Text("\(song.name) in \(songAlbum.name)")
            } else {
                Text("\(song.name)")
            }
        }
    }
}
