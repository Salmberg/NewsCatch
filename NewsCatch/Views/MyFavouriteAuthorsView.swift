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
            ScrollView{
                ZStack{
                    HStack{
                        VStack{
                            ForEach(viewModel.MyAuthors, id: \.username) { user in
                                
                                let pictureURL = user.imageURL
                                if pictureURL != "" {
                                    KFImage(URL(string: pictureURL))
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                        .padding()
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                        .padding()
                                }
                                 
                                Text(user.username)
                                    .font(.system(size: 15))
                            }
                        }
                    }
                }
            }
            .onAppear(perform: viewModel.getMyFavouriteAuthors)
        }
    }
}

