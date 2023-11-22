//
//  EditAlbumView.swift
//  ProjectA4
//
//  Created by Yannis Obert on 22/11/2023.
//

import SwiftUI


struct EditAlbumView: View {
    @Binding var album: Album
    @Binding var index: Int
    @EnvironmentObject var sharedDataManager: SharedDataManager
    
    @State private var updatedName: String = ""
    @State private var updatedBand: String = ""
    @State private var updatedImage: String = ""
    @State private var updatedCreationDate = Date()
    @State private var updateAlbum: Album = Album(name: "test", band: "test", image: "test", creationDate: Date())
    
    var body: some View {
        VStack {
            TextField("Enter album name", text: $updatedName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Enter album band", text: $updatedBand)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Enter album image url", text: $updatedImage)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            DatePicker("Date de création", selection: $updatedCreationDate, displayedComponents: .date)

            .pickerStyle(WheelPickerStyle())
            Button("Save Changes") {
                album.name = updatedName
                album.band = updatedBand
                album.image = updatedImage
                album.creationDate = updatedCreationDate
                
                sharedDataManager.albumManager.updateAlbum(index: index, album: album)
            }
        }
        .navigationTitle("Edit Album")
    }
}
