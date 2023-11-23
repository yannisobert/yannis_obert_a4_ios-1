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
    
    @State private var isShowingAlert = false
    
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
                
                
                
                if album.name != "" && album.band != ""{
                    sharedDataManager.albumManager.updateAlbum(index: index, album: album)
                } else {
                    isShowingAlert = true
                }
            }
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Erreur"), message: Text("Le nom de l'album et du groupe ne peuvent pas être vide"), dismissButton: .default(Text("OK")))
        }
        .navigationTitle("Edit Album")
    }
}
