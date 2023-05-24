//
//  ContentView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State var isProfile = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                NewsFeedView()
                    .edgesIgnoringSafeArea(.all)
            } else {
                LoginView()
                    .edgesIgnoringSafeArea(.all)
            }
        }
       
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
