//
//  AdminDeleteArticles.swift
//  NewsCatch
//
//  Created by Youssef Azroun on 2023-06-04.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Kingfisher

struct AdminDeleteArticles: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = NewsFeedViewModel()
    @State private var selectedArticle: Article? = nil
    
    var filteredArticles: [Article] {
        return viewModel.articles.sorted { $0.date > $1.date }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color.black
                        .frame(height: 110) // Adjust the height as needed
                    Text("All News")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .bold()
                }
                .edgesIgnoringSafeArea(.top)
                .frame(height: 110) // Adjust the height as needed
                
                VStack { // Move the NavigationView inside a VStack
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(filteredArticles, id: \.heading) { article in
                                NavigationLink(
                                    destination: ArticleView(article: article),
                                    tag: article,
                                    selection: $selectedArticle
                                ) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 0) {
                                            HStack {
                                                Image(systemName: "clock")
                                                    .resizable()
                                                    .frame(width: 15, height: 15)
                                                    .foregroundColor(.gray)
                                                    .padding(.leading, 10)
                                                Text(article.relativeDate)
                                                    .foregroundColor(.gray)
                                                
                                            }
                                            Text(article.heading)
                                                .font(.custom("BebasNeue-Regular", size: 30))
                                                .padding(.leading, 10)
                                                .padding(.bottom, 20)
                                        }
                                        
                                        Spacer()
                                        
                                        if let pictureURL = article.pictureURL {
                                            KFImage(URL(string: pictureURL))
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(10)
                                                .padding()
                                        } else {
                                            Image("Image")
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(10)
                                                .padding()
                                        }
                                        
                                        Button(action: {
                                            viewModel.deleteArticle(article)
                                        }) {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                Divider()
                                    .padding(.horizontal, 10)
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                    
                    Spacer()
                }
                .navigationBarTitle("", displayMode: .inline)
            }
            .navigationBarBackButtonHidden(true) // Hide the default back button
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            )
        }
        .onAppear {
            viewModel.getArticleFeed()
        }
        .navigationBarTitle("", displayMode: .inline) // Set an empty title to keep the navigation bar visible
    }
}


struct AdminDeleteArticles_Previews: PreviewProvider {
    static var previews: some View {
        AdminDeleteArticles()
    }
}
