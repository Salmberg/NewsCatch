
//  AmusementView.swift
//  NewsApp
//
//  Created by Linda Bergsängel on 2023-05-23.
//

import SwiftUI
import Kingfisher

struct AmusementView: View {
    @StateObject var viewModel = AmusementViewModel()
    @State private var selectedArticle: Article? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    Color.black
                        .frame(height: 110) // Adjust the height as needed
                    Text("Nöje")
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
                            ForEach(viewModel.amusementArticles, id: \.heading) { article in
                                NavigationLink(
                                    destination: ArticleView(article: article)
                                        .navigationBarHidden(true), // Hide the navigation bar in the destination view
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
            .onAppear {
                viewModel.getArticlesFromDb()
            }
            .navigationBarTitle("", displayMode: .inline) // Set an empty title to keep the navigation bar visible
        }
    }
}



struct AmusementView_Previews: PreviewProvider {
    static var previews: some View {
        AmusementView()
    }
}
