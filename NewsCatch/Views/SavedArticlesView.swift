//
//  SavedArticlesView.swift
//  NewsCatch
//
//  Created by Youssef Azroun on 2023-05-30.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Kingfisher


struct SavedArticlesView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = NewsFeedViewModel()
    @State private var savedArticles: [Article] = []
    @State private var selectedArticle: Article? = nil
    
    var body: some View {
        NavigationView {
            List(savedArticles, id: \.heading) { article in
                Button(action: {
                    selectedArticle = article
                }) {
                    Text(article.heading)
                        .bold()
                }
            }
            .navigationBarTitle("Saved Articles")
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
            })
            .fullScreenCover(item: $selectedArticle) { article in
                ArticleDetailView(article: article)
            }
        }
        .onAppear {
            viewModel.getSavedArticles { articles in
                savedArticles = articles
            }
        }
    }
    
}

struct ArticleDetailView: View {
    var article: Article
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    
                    Text(article.heading)
                        .font(.title)
                        .padding()
                    
                    Text(article.content)
                    
                    Spacer()
                    
                    Text("Published in: \(Article.dateFormatter.string(from: article.date))")
                        .padding()
                }
            }
            
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Go Back")
                }
                .foregroundColor(.blue)
            }
            )
        }
    }
}



struct SavedArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedArticlesView()
    }
}
