//
//  MyFavouriteAuthorsView.swift
//  NewsCatch
//
//  Created by Linda Bergsängel on 2023-06-01.
//

import SwiftUI

struct MyFavouriteAuthorsView: View {
    @StateObject var viewModel = MyFavouriteAuthorViewModel()
    var body: some View {
        NavigationView {
            ScrollView{
                ZStack{
                    HStack{
                        VStack{
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 80))
                                .padding(15)
                            Text("Skribent 1")
                                .font(.system(size: 15))
                        }
                    }
                    
                }
            }
        }
       
    }
}

