//
//  Album.swift
//  ProjectA4
//
//  Created by Yannis Obert on 21/11/2023.
//

import Foundation

struct Album: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var band: String
    var image: String
    var creationDate: Date

    init(id: UUID = UUID(), name: String, band: String, image: String, creationDate: Date) {
        self.id = id
        self.name = name
        self.band = band
        self.image = image
        self.creationDate = creationDate
    }
}
