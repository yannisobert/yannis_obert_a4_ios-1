//
//  SharedDataManager.swift
//  ProjectA4
//
//  Created by Yannis Obert on 23/11/2023.
//

import Foundation

class SharedDataManager: ObservableObject {
    @Published var albumManager = AlbumManager()
    @Published var songManager = SongManager()
}
