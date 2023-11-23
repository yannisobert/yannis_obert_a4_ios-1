//
//  Song.swift
//  ProjectA4
//
//  Created by Yannis Obert on 21/11/2023.
//

import Foundation

struct Song: Identifiable, Equatable, Hashable {
    var id: UUID = UUID()
    var name: String
    var albumID: UUID

    init(id: UUID = UUID(), name: String, albumID: UUID) {
        self.id = id
        self.name = name
        self.albumID = albumID
    }
}
