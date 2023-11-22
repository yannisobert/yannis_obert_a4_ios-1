//
//  Top10BillboardView.swift
//  ProjectA4
//
//  Created by Yannis Obert on 22/11/2023.
//

import SwiftUI

struct Top10BillboardView: View {
    @State private var topSongs: [TopSong] = []

    var body: some View {
        VStack {
        Text("Top 10 Billboard")
            List(topSongs, id: \.self) { song in
                            Text("\(song.title) by \(song.artist.name)")
                        }
                        .onAppear(perform: loadData)
                        .navigationTitle("Top 10 Billboard")
        }
    }
    
    func loadData() {
            guard let url = URL(string: "https://api.deezer.com/chart/0/tracks") else {
                print("Invalid URL")
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let topSongsResponse = try decoder.decode(TopSongsResponse.self, from: data)

                    DispatchQueue.main.async {
                        self.topSongs = topSongsResponse.data
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }

            task.resume()
        }
}


struct TopSongsResponse: Codable {
    let data: [TopSong]
}

struct TopSong: Codable, Hashable {
    let title: String
    let artist: Artist
}

struct Artist: Codable, Hashable {
    let name: String
}

struct Top10BillboardView_Previews: PreviewProvider {
    static var previews: some View {
        Top10BillboardView()
    }
}
