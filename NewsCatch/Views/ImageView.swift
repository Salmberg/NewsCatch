//
//  ImageView.swift
//  NewsCatch
//
//  Created by Philip Miranda on 2023-05-28.
//

import SwiftUI
import UIKit
import FirebaseStorage
import FirebaseFirestore
import Kingfisher

struct ImageView: View {
    @State private var isPickerShowing = false
    @State private var selectedImage: UIImage?
    @State private var retrievedImages = [UIImage]()
    var imageURL: String

    var body: some View {
        
        Text("ImageView Placeholder")
        VStack {
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            
            KFImage(URL(string: imageURL))
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                // Show the image picker
                isPickerShowing = true
            } label: {
                Text("Select a Photo")
            }
            
            if selectedImage != nil {
                Button {
                    // Upload the image
                    uploadPhoto()
                } label: {
                    Text("Upload Photo")
                }
            }
            
            Divider()
            
            ScrollView {
                VStack {
                    // Loop through the images and display them
                    ForEach(retrievedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
                }
            }
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
            // Image picker
            ImageViewModel(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
        }
        .onAppear {
            retrievePhotos()
        }
    }
    
    func uploadPhoto() {
        guard let selectedImage = selectedImage else {
            return
        }
        
        // Create storage reference
        let storageRef = Storage.storage().reference()
        
        // Turn our image into data
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        // Specify the file path and name
        let path = "Article-Image/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        // Upload the data
        let _ = fileRef.putData(imageData, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                // Save a reference to the file in Firestore DB
                let db = Firestore.firestore()
                db.collection("images").document().setData(["url": path]) { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            // Add the uploaded image to the list of images for display
                            retrievedImages.append(selectedImage)
                        }
                    }
                }
            }
        }
    }
    
    func retrievePhotos() {
        let db = Firestore.firestore()
        
        db.collection("images").getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                var paths = [String]()
                
                // Loop through all the returned docs
                for doc in snapshot!.documents {
                    // Extract the file path and add it to the array
                    if let path = doc["url"] as? String {
                        paths.append(path)
                    }
                }
                
                // Loop through each file path and fetch the data from storage
                for path in paths {
                    // Get a reference to storage
                    let storageRef = Storage.storage().reference()
                    
                    // Specify the path
                    let fileRef = storageRef.child(path)
                    
                    // Retrieve the data
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        if error == nil && data != nil {
                            // Create a UIImage and put it into our array for display
                            if let image = UIImage(data: data!) {
                                DispatchQueue.main.async {
                                    retrievedImages.append(image)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageURL: "https://example.com/image.jpg")
    }
}
