//
//  Song.swift
//  ProjectA4
//
//  Created by Yannis Obert on 21/11/2023.
//

import Foundation

struct Song: Hashable {
    let id: UUID = UUID()
    var name: String
    var albumID: UUID

}
