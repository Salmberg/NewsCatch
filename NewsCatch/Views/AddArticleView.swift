//
//  AddArticleView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI
import UIKit
import FirebaseStorage

struct AddArticleView: View {
    @StateObject var viewModel = AddArticleViewModel()
    @StateObject private var mapAPI = MapAPI()
    let lists = ArticleLists()
    // For alert-popup
    @State var showingAlert = false
    @FocusState private var isFocused: Bool
    
    // For Category label
    @State var catLabel = "Unspecified"
    
    // Needed to be able to "dismiss" the view
    @Environment(\.presentationMode) var presentation
    
    // Image picker
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            TextEditor(text: $viewModel.titleContent)
                .padding(30)
                .background(Color(red: 240/255, green: 240/255, blue: 245/255))
                .frame(height: 100)
                .foregroundColor(viewModel.titleContent == "Enter Title..." ? .gray : .black)
                .onTapGesture {
                    if viewModel.titleContent == "Enter Title..." {
                        viewModel.titleContent = ""
                    }
                }
            
            TextEditor(text: $viewModel.textContent)
                .padding(30)
                .background(Color(red: 240/255, green: 240/255, blue: 245/255))
                .foregroundColor(viewModel.textContent == "Enter your article text here..." ? .gray : .black)
                .onTapGesture {
                    if viewModel.textContent == "Enter your article text here..." {
                        viewModel.textContent = ""
                    }
                }
            
            Menu {
                Button {
                    viewModel.setCategory(cat: Category.foreign)
                    catLabel = viewModel.categoryString
                } label: {
                    Text("Foreign")
                }
                Button {
                    viewModel.setCategory(cat: Category.sports)
                    catLabel = viewModel.categoryString
                } label: {
                    Text("Sports")
                }
                Button {
                    viewModel.setCategory(cat: Category.amusement)
                    catLabel = viewModel.categoryString
                } label: {
                    Text("Amusement")
                }
            } label: {
                Image(systemName: "newspaper.circle.fill")
                Text(catLabel)
            }
            .padding([.bottom, .trailing], 25)
            
            Button(action: {
                isShowingImagePicker = true
            }) {
                Text("Add Image")
            }
            .padding(.bottom, 30)

            
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
            }
            
            TextEditor(text: $viewModel.locationContent)
                .padding(30)
                .background(Color(red: 240/255, green: 240/255, blue: 245/255))
                .frame(height: 100)
                .foregroundColor(viewModel.locationContent == "Enter Location..." ? .gray : .black)
                .onTapGesture {
                    if viewModel.locationContent == "Enter Location..." {
                        viewModel.locationContent = ""
                    }
                }
                .focused($isFocused)
                .onChange(of: isFocused) { isFocused in
                    if isFocused == false{
                        mapAPI.getLocation(adress: viewModel.locationContent, delta: 0.5)
                        mapAPI.getLocation(adress: viewModel.locationContent, delta: 0.5)
                        print("AddArticle")
                        print(mapAPI.latitude)
                        print(mapAPI.longitude)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            viewModel.latitude = mapAPI.latitude
                            viewModel.longitude = mapAPI.longitude
                        }
                    }
                }

            Button("Publish") {
                if let image = selectedImage {
                    // Upload the image
                    uploadImage(image)
                } else {
                    // No image selected, proceed without uploading
                    viewModel.requestArticle()
                    showingAlert = true
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Thank you for your submission"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .cancel(Text("OK"), action: {
                        presentation.wrappedValue.dismiss() // Dismiss the view
                    })
                )
            }
        }
        .background(Color(red: 240/255, green: 240/255, blue: 245/255))
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            ImagePickerModel(selectedImage: $selectedImage)
        }
    }
    
    private func uploadImage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        let filename = UUID().uuidString + ".jpg"
        let storageRef = Storage.storage().reference().child("article_images/\(filename)")
        
        let uploadTask = storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("Image upload error: \(error.localizedDescription)")
            } else {
                storageRef.downloadURL { url, error in
                    if let error = error {
                        print("Download URL error: \(error.localizedDescription)")
                    } else if let downloadURL = url {
                        viewModel.pictureURLL = downloadURL.absoluteString
                        viewModel.requestArticle()
                        showingAlert = true
                    }
                }
            }
        }
    }
    
    private func loadImage() {
        guard let selectedImage = selectedImage else {
            return
        }
        
        // Perform any necessary operations with the selected image here
    }
}
