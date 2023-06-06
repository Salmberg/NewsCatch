//
//  WriterArticleContentView.swift
//  NewsCatch
//
//  Created by Youssef Azroun on 2023-06-06.
//

import SwiftUI
import Kingfisher

struct WriterArticleContentView: View {
    
    var article: Article
    @StateObject private var viewModel = NewsFeedViewModel()
    @StateObject private var favouriteAuthorVM = MyFavouriteAuthorViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    
    
    var body: some View {
        VStack {
            ScrollView {
               
                Text(article.heading)
                    .font(.custom("BebasNeue-Regular", size: 30))
                    .padding()
                                    
                if let pictureURL = article.pictureURL {
                    KFImage(URL(string: pictureURL))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
                }
                
                Text(article.content)
                    .padding()
                    .font(.custom("CrimsonText-Regular", size: 18))
               
                Spacer()
                     
                HStack{
                    Image(systemName: "calendar")
                    Text(Article.dateFormatter.string(from: article.date))
                        .padding()
                }

                Button(action: {
                    viewModel.saveArticle(article)
                    showAlert = true
                }) {
                    HStack {
                        Image(systemName: "bookmark")
                            
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Article saved!"),
                        message: Text("The article is now under saved articles in your profile"),
                        dismissButton: .default(Text("OK"))
                    
                        
                    )
                }
                .padding()
            }
            .onAppear {
                viewModel.getSavedArticles { articles in
                    // Update the saved articles in the view model
                    viewModel.savedArticles = articles
                }
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
        }
        )
    }
    
}

/*struct WriterArticleContentView_Previews: PreviewProvider {
    static var previews: some View {
        WriterArticleContentView()
    }
}*/
