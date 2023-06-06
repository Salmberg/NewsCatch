//
//  WriterArticlesView.swift
//  NewsCatch
//
//  Created by Viktor on 2023-06-01.
//

import Foundation
import SwiftUI
import Kingfisher

struct WriterArticlesView: View {
    @State private var isMenuActive: Bool = false
    var writer : String
    @StateObject var viewModel = WriterArticlesViewModel()
    @StateObject var favouriteWriterVM = MyFavouriteAuthorViewModel()
    @State private var selectedArticleSheet: Article? = nil // New state variable
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        Color.black
                            .frame(height: 110) // Adjust the height as needed
                        Text(writer + "'s Articles")
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
                                ForEach(viewModel.articles, id: \.heading) { article in
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
                        VStack{
                            Button(action: {
                                favouriteWriterVM.saveFavouriteAuthor(userName: writer)
                            }, label: {
                                Text("Följ")
                            })
                            .buttonStyle(BorderedProminentButtonStyle())
                        }
                    }
                    Spacer()
                }
                .navigationBarTitle("", displayMode: .inline)
            }
            
            // Menu view
            MenuView(isMenuActive: $isMenuActive)
                .frame(width: UIScreen.main.bounds.width * 1) // Adjust the width as needed
                .offset(x: isMenuActive ? 0 : -UIScreen.main.bounds.width) // Apply the offset to control the slide-out animation
                .animation(.easeInOut) // Apply animation
                .zIndex(1) // Ensure the menu appears above the content
        }
        .modifier(InitialMenuActivationModifier(isMenuActive: $isMenuActive))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.username = self.writer
            viewModel.getArticlesFromDb()
        }
        .navigationBarTitle("", displayMode: .inline) // Set an empty title to keep the navigation bar visible
        .sheet(item: $selectedArticleSheet) { article in
            WriterArticleContentView(article: article)
        } // Present the sheet when an article is selected
    }
}



struct WriterArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        WriterArticlesView(writer: "unknown")
    }
}
