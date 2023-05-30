//
//  ImageViewModel.swift
//  NewsCatch
//
//  Created by Philip Miranda on 2023-05-28.
//

import Foundation
import UIKit
import SwiftUI
import FirebaseStorage

struct ImageViewModel: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPickerShowing: Bool
    
    
    func makeUIViewController (context: Context) -> some UIViewController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        
        return imagePicker
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context:
                                Context) {
    }
    
    func makeCoordinator () -> Coordinator {
        return Coordinator (self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate,
                       UINavigationControllerDelegate {
        
        var parent: ImageViewModel
        init(_ picker: ImageViewModel) {
            self.parent = picker
        }
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey :
                                                                            Any]) {
            // Run code when the user has selected an image
            print("image selected")
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as?
                UIImage {
                
                // We were able to get the image
                DispatchQueue.main.async {
                    self.parent.selectedImage = image
                }
                
            }
            // Dismiss the picker
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // Run code when the user has cancelled the picker UI
            print("cancelled")
            
            // Dismiss the picker
            parent.isPickerShowing = false
        }
    }
}

