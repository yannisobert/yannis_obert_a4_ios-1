//
//  SongManager.swift
//  ProjectA4
//
//  Created by Yannis Obert on 21/11/2023.
//

import Foundation

class SongManager: ObservableObject {
    @Published var songs: [Song] = []

    func saveSong(songName: String, albumID: UUID) {
        songs.append(Song(name: songName, albumID: albumID))
    }
    
    func updateSong(index: Int, song: Song) {
        songs[index] = song
    }
}
