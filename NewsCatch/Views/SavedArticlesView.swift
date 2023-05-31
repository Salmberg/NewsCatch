//
//  SavedArticlesView.swift
//  NewsCatch
//
//  Created by Youssef Azroun on 2023-05-30.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct SavedArticlesView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = NewsFeedViewModel()
    @State private var savedArticles: [Article] = []
    
    var body: some View {
        List(savedArticles, id: \.heading) { article in
            Text(article.heading)
        }
        .navigationBarTitle("Saved Articles")
        .navigationBarItems(trailing: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
        })
        .onAppear {
            viewModel.getSavedArticles { articles in
                savedArticles = articles
            }
        }
    }
}


struct SavedArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedArticlesView()
    }
}
