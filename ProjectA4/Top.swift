//
//  Top.swift
//  ProjectA4
//
//  Created by Yannis Obert on 23/11/2023.
//

import SwiftUI

struct TopSong: Codable, Hashable {
    let title: String
    let artist: Artist
}

struct TopSongsResponse: Codable {
    let data: [TopSong]
}

struct Top10BillboardView_Previews: PreviewProvider {
    static var previews: some View {
        Top10BillboardView()
    }
}

struct Artist: Codable, Hashable {
    let name: String
}
