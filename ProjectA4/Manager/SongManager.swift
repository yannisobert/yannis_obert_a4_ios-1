//
//  SongManager.swift
//  ProjectA4
//
//  Created by Yannis Obert on 21/11/2023.
//

import Foundation

struct SongManager {
    var selectableSongs: [Song] = []
    var songs: [Song] = []

    mutating func saveSong(songName: String, albumID: UUID) {
        let newSong = Song(name: songName, albumID: albumID)
        selectableSongs.append(newSong)
        songs.append(newSong)
    }
}
