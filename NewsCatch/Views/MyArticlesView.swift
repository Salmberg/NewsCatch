//
//  ForeignView.swift
//  NewsApp
//
//  Created by Linda Bergsängel on 2023-05-23.
//

import SwiftUI

struct MyArticlesView: View {
    @StateObject var viewModel = MyArticlesViewModel()
    @State private var isMenuActive: Bool = false
    @State private var selectedArticle: Article? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        Color.black
                            .frame(height: 110) // Adjust the height as needed
                        Text("Utrikes")
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
                                    NavigationLink(
                                        destination: ArticleView(article: article),
                                        tag: article,
                                        selection: $selectedArticle
                                    ) {
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
                                            
                                            Image("Image")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .padding(10)
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
                }
                
            }
        }
    }
}

struct ForeignView_Previews: PreviewProvider {
    static var previews: some View {
        ForeignView()
    }
}
