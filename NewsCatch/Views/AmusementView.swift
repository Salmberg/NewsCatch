//
//  AmusementView.swift
//  NewsApp
//
//  Created by Linda Bergsängel on 2023-05-23.
//

import SwiftUI

struct AmusementView: View {
    @StateObject var viewModel = AmusementViewModel()
    @State private var isMenuActive: Bool = false
    @State private var selectedArticle: Article? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
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
                                        destination: ArticleView(article: article),
                                        tag: article,
                                        selection: $selectedArticle
                                    ) {
                                        HStack {
                                            Text(article.heading)
                                                .font(.title)
                                                .bold()
                                                .padding(.leading, 10)
                                            
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
                        .frame(maxHeight: .infinity) // Occupy the remaining available space
                        
                        Spacer() // Add a spacer to push the content above the toolbar
                    }
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


struct AmusementView_Previews: PreviewProvider {
    static var previews: some View {
        AmusementView()
    }
}
