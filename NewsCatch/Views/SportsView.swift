//
//  SportsNewsView.swift
//  NewsApp
//
//  Created by Linda Bergsängel on 2023-05-22.
//

import SwiftUI
import Kingfisher

struct SportsView: View {
    @StateObject var viewModel = SportsViewModel()
    @State private var isMenuActive: Bool = false
    @State private var selectedArticle: Article? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        Color.black
                            .frame(height: 110) // Adjust the height as needed
                        Text("Sport")
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
                                ForEach(viewModel.sportsArticles, id: \.heading) { article in
                                    NavigationLink(
                                        destination: ArticleView(article: article),
                                        tag: article,
                                        selection: $selectedArticle
                                    ) {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 0) {
                                                HStack{
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
                viewModel.getArticlesFromDb()
            }
            .navigationBarTitle("", displayMode: .inline) // Set an empty title to keep the navigation bar visible
            .navigationBarItems(
                leading: Button(action: {
                    isMenuActive.toggle()
                }) {
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
            )
        }
    }
}

struct SportView_Previews: PreviewProvider {
    static var previews: some View {
        SportsView()
    }
}
