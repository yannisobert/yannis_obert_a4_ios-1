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
    
    @State private var updateAlbum: Album = Album(name: "test", band: "test", image: "test", creationDate: Date())
    
    @State private var isShowingAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("Enter album name", text: $album.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Enter album band", text: $album.band)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Enter album image url", text: $album.image)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            DatePicker("Date de création", selection: $album.creationDate, displayedComponents: .date)

            .pickerStyle(WheelPickerStyle())
            Button("Save Changes") {
                album.name = album.name
                album.band = album.band
                album.image = album.image
                album.creationDate = album.creationDate
                
                if album.name != "" && album.band != ""{
                    sharedDataManager.albumManager.updateAlbum(index: index, album: album)
                    sharedDataManager.objectWillChange.send()
                    presentationMode.wrappedValue.dismiss()
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
