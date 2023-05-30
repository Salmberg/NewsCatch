//
//  ImageView.swift
//  NewsCatch
//
//  Created by Philip Miranda on 2023-05-28.
//
/*
import SwiftUI
import UIKit
import FirebaseStorage
import FirebaseFirestore


struct ImageView: View {
    
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    @State var retrievedImages = [UIImage]()
    
    var body: some View {
        VStack {
            
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            Button {
                // Show the image picker
                isPickerShowing = true
            } label: {
                Text("Select a Photo")
            }
            
            if selectedImage != nil {
                Button {
                    //Upload the image
                    uploadPhoto()
                } label: {
                    Text("Upload Photo")
                }
            }
            
            Divider()
            
            ScrollView {
                VStack {
                    
                    // Loop through the images nd display them
                    ForEach(retrievedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 200, height: 200)
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
    }
    
    func uploadPhoto () {
        
        //Make sure that the selected image property isn't nil
        guard selectedImage != nil else {
            return
        }
        
        // Create storage reference
        
        let storageRef = Storage.storage ().reference ()
        
        // Turn our image into data
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        
        // Check that we were able to convert it to data
        guard imageData != nil else {
            return
        }
        // Specify the file path and name
        let path = "Article-Image/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
    
        
        // Upload that data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata,
            error in
            // Check for errors
            if error == nil && metadata != nil {
                
                // Save a reference to the file in Firestore DB
                let db = Firestore.firestore ()
                db.collection("images").document ().setData(["url":path]) { error in
                    
                    // If there were no errors, display the new image
                    if error == nil {
                    DispatchQueue.main.async {
                        
                        // Add the uploaded image to the list of images for display
                        self.retrievedImages.append(self.selectedImage!)
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    
        func retrievePhotos () {
            // Get the data from the database
            
            let db = Firestore.firestore()
            
            db.collection("images").getDocuments { snapshot, error in
                
                if error == nil && snapshot != nil {
                    var paths = [String]()
                    
                    //Loop through all the returned docs
                    for doc in snapshot!.documents {
                        
                        // Extract the file path and add to array
                        paths.append(doc["url"] as! String)
                        
                    }
                    
                    // Loop through each file path and fetch the data from storage
                    for path in paths {
                        // Get a reference to storage
                        let storageRef = Storage.storage ().reference()
                        
                        // Specify the path
                        let fileRef = storageRef.child(path)
                        
                        // Retrieve the data
                        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                            
                            // Check for errors
                            if error == nil && data != nil {
                                
                                // Create a UIImage and put it into our array for display
                                if let image = UIImage(data: data!){
                                    
                                    DispatchQueue.main.async {
                                        retrievedImages.append(image)
                                    }
                                }
                                
                            }
                        }
                    } // end loop through paths
                    
                }
            }
        }
        // Display the images
    }



struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}

*/
