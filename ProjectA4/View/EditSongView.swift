//
//  EditSongView.swift
//  ProjectA4
//
//  Created by Yannis Obert on 22/11/2023.
//

import SwiftUI

class EditSongViewModel: ObservableObject {
    @Published var editedSong: Song

    init(song: Song) {
        self.editedSong = song
    }
}

struct EditSongView: View {
    @EnvironmentObject var sharedDataManager: SharedDataManager
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: EditSongViewModel

    init(song: Song, isPresented: Binding<Bool>) {
        _viewModel = ObservedObject(initialValue: EditSongViewModel(song: song))
        _isPresented = isPresented
    }

    var body: some View {
        Form {
            Section(header: Text("Song Details")) {
                TextField("Song Name", text: $viewModel.editedSong.name)
            }
            //Section(header: Text("Album Details")) {
            //    // Add any other details you want to edit
            //}
        }
        .navigationTitle("Edit Song")
        .navigationBarItems(
            trailing: Button("Save", action: saveChanges)
        )
        
    }

    func saveChanges() {
        if let index = sharedDataManager.songManager.songs.firstIndex(where: { $0.id == viewModel.editedSong.id }) {
            sharedDataManager.songManager.songs[index] = viewModel.editedSong
        }
        dismiss()
    }

    func dismiss() {
        isPresented = false
    }
}
