//
//  ForeignView.swift
//  NewsApp
//
//  Created by Linda Bergsängel on 2023-05-23.
//

import SwiftUI
import Kingfisher

struct MyArticlesView: View {
    @StateObject var viewModel = MyArticlesViewModel()
    @State private var isMenuActive: Bool = false
    @State private var selectedArticleSheet: Article? = nil 
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        Color.black
                            .frame(height: 110) // Adjust the height as needed
                        Text("Mina artiklar")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .bold()
                    }
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 110) // Adjust the height as needed
                    HStack{
                        
                        Spacer()
                    }
                    .background(Color.gray)
                    
                    VStack {
                        ScrollView {
                            VStack {
                                ForEach(viewModel.myArticles, id: \.heading) { article in
                                    Button(action: {
                                        selectedArticleSheet = article // Set the selected article for the sheet
                                    }) {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 0) {
                                                HStack(spacing: 0) { // Add spacing: 0 to the HStack
                                                    Image(systemName: "clock")
                                                        .resizable()
                                                        .frame(width: 15, height: 15)
                                                        .foregroundColor(.gray)
                                                        .padding(.leading, 10)
                                                    Text(article.relativeDate)
                                                        .foregroundColor(.gray)
                                                }
                                                Text(article.heading)
                                                    .font(.title)
                                                    .bold()
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
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    Divider()
                                        .padding(.horizontal, 10)
                                }
                            }
                        }
                        .frame(maxHeight: .infinity)
                        .onAppear(perform: viewModel.getMyArticlesFomDB)
                        
                        Spacer()
                    }
                    .navigationBarTitle("", displayMode: .inline)
                    .sheet(item: $selectedArticleSheet) { article in
                        WriterArticleContentView(article: article)
                    }
                }
                
            }
        }
    }
}
