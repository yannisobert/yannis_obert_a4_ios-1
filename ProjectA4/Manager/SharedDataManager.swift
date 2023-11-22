//
//  SharedDataManager.swift
//  ProjectA4
//
//  Created by Yannis Obert on 22/11/2023.
//

import SwiftUI

class SharedDataManager: ObservableObject {
    @Published var albumManager = AlbumManager()
    @Published var songManager = SongManager()
}
