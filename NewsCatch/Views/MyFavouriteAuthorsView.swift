//
//  MyFavouriteAuthorsView.swift
//  NewsCatch
//
//  Created by Linda Bergsängel on 2023-06-01.
//

import SwiftUI
import Kingfisher


struct MyFavouriteAuthorsView: View {
    @StateObject var viewModel = MyFavouriteAuthorViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    HStack {
                        VStack {
                            ForEach(viewModel.MyAuthors, id: \.username) { user in
                                HStack {
                                    VStack {
                                        let pictureURL = user.imageURL
                                        if pictureURL != "" {
                                            NavigationLink(
                                                destination: WriterArticlesView(writer: user.username)
                                            ) {
                                                KFImage(URL(string: pictureURL!))
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(10)
                                                    .padding()
                                            }
                                            .navigationBarBackButtonHidden(true)
                                        } else {
                                            NavigationLink(
                                                destination: WriterArticlesView(writer: user.username)
                                            ) {
                                                Image(systemName: "person.crop.circle.fill")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(10)
                                                    .padding()
                                            }
                                            .navigationBarBackButtonHidden(true)
                                        }
                                        
                                        Text(user.username)
                                            .font(.system(size: 15))
                                    }
                                    Button(action: {
                                        viewModel.removeAuthor(username: user.username)
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .padding()
                                            .imageScale(.large)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .onAppear(perform: viewModel.getMyFavouriteAuthors)
        }
        .navigationBarHidden(true)
    }
}
