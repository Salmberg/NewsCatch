//
//  ArticleImageViewModel.swift
//  NewsCatch
//
//  Created by Philip Miranda on 2023-05-31.
//

import SwiftUI
import Kingfisher

class ArticleImageViewModel: ObservableObject {
    @Published var isPickerShowing = false
    @Published var selectedImage: UIImage?
    @Published var retrievedImages: [UIImage] = []

    func uploadPhoto() {
        guard let selectedImage = selectedImage else {
            return
        }

        // Implement the logic to upload the photo to a server or storage service

        // Assuming the upload is successful, append the uploaded image to the retrieved images
        retrievedImages.append(selectedImage)

        // Clear the selected image after successful upload
        self.selectedImage = nil
    }

    func retrievePhotos() {
        // Implement the logic to retrieve the images from a server or storage service
        // and assign them to the retrievedImages property
        // For example, you can use Kingfisher to download the images asynchronously

        // Mocking retrieved images for demonstration
        retrievedImages = [
            UIImage(named: "image1")!,
            UIImage(named: "image2")!,
            UIImage(named: "image3")!
        ]
    }
}


