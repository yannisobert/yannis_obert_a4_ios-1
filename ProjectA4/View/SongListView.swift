//
//  SongListView.swift
//  ProjectA4
//
//  Created by Yannis Obert on 22/11/2023.
//

import SwiftUI

struct SongListView: View {
    @EnvironmentObject var sharedDataManager: SharedDataManager
    @State public var isEditing = false
    @State public var selectedSong: Song = Song(name: "test", albumID: UUID())
    @State public var selectedSongIndex: Int = 666
    
    var body: some View {
        List {
            ForEach(sharedDataManager.songManager.songs, id: \.self) { song in
                if let songAlbum = sharedDataManager.albumManager.albums.first(where: { $0.id == song.albumID }) {
                    HStack {
                        Text("\(song.name) in \(songAlbum.name)")
                        Spacer()
                        .padding(.trailing, 10)
                    }
                } else {
                    Text("\(song.name)")
                }
            Button(action: {
                selectedSong = song
                if let index = sharedDataManager.songManager.songs.firstIndex(of: song) {
                    selectedSongIndex = index
                }
                isEditing.toggle()
            }) {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
            Button(action: {
                if let index = sharedDataManager.songManager.songs.firstIndex(of: song) {
                    sharedDataManager.songManager.songs.remove(at: index)
                    sharedDataManager.objectWillChange.send()
                }
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .onDelete(perform: { indexSet in
                sharedDataManager.songManager.songs.remove(atOffsets: indexSet)
            })
        }
        .navigationBarItems(trailing: EditButton())
        .sheet(isPresented: $isEditing) {
            EditSongView(song: $selectedSong, index: $selectedSongIndex)
                    }
        .onAppear{
            sharedDataManager.objectWillChange.send()
        }
        .navigationTitle("Toutes les chansons")
    }
}
