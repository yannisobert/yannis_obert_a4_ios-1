//
//  SongManager.swift
//  ProjectA4
//
//  Created by Yannis Obert on 21/11/2023.
//

import Foundation

class SongManager: ObservableObject {
    var selectableSongs: [Song] = []
    @Published var songs: [Song] = []

    func saveSong(songName: String, albumID: UUID) {
        //selectableSongs.append(Song(name: songName, albumID: albumID))
        songs.append(Song(name: songName, albumID: albumID))
        print(selectableSongs)
    }
}
