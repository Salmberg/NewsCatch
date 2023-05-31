//
//  ArticleImageView.swift
//  NewsCatch
//
//  Created by Philip Miranda on 2023-05-30.
//

import SwiftUI

struct ArticleImageView: View {
    @StateObject private var viewModel = ArticleImageViewModel()
    @State var isPickerShowing = false

    var body: some View {
        VStack {
            if let selectedImage = viewModel.selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .frame(width: 200, height: 200)
            }

            Button("Select a Photo") {
                viewModel.isPickerShowing = true
            }

            if viewModel.selectedImage != nil {
                Button("Upload Photo") {
                    viewModel.uploadPhoto()
                }
            }

            Divider()

            ScrollView {
                VStack {
                    ForEach(viewModel.retrievedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isPickerShowing, onDismiss: nil) {
            ImagePickerModel(selectedImage: $viewModel.selectedImage)
        }
        .onAppear {
            viewModel.retrievePhotos()
        }
    }
}
