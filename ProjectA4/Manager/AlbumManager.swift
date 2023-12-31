//
//  AlbumManager.swift
//  ProjectA4
//
//  Created by Yannis Obert on 21/11/2023.
//

import Foundation

class AlbumManager: ObservableObject {
    @Published public var selectableAlbums: [Album] = []

    func saveAlbum(albumName: String, bandName: String, albumImage: String, albumCreationDate: Date) {
        let newAlbum = Album(name: albumName, band: bandName, image: albumImage, creationDate: albumCreationDate)
        selectableAlbums.append(newAlbum)
    }
    
    func updateAlbum(index: Int, album: Album) {
        selectableAlbums[index] = album
    }
}
