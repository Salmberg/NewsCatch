//
//  NewsFeedView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI

struct NewsFeedView: View {
    @StateObject var viewModel = NewsFeedViewModel()
    //@State private var isProfileActive: Bool = false
    @State private var isMenuActive: Bool = false
    @State private var menuOffset: CGFloat = -UIScreen.main.bounds.width
    @State private var latestNewsSelected = true
    @State private var allNewsSelected = false
    @State private var selectedArticle: Article? = nil

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        Color.black
                            .frame(height: 110) // Adjust the height as needed
                        Text("News")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .bold()
                    }
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 110) // Adjust the height as needed
                    
                 
                        HStack{
                            ZStack {
                                Button(action: {
                                    latestNewsSelected.toggle()
                                    allNewsSelected = false // Deselect the "All news" button
                                }) {
                                    Text("Latest news")
                                        .font(.title2)
                                        .bold()
                                        .padding(.leading, 30)
                                        .foregroundColor(latestNewsSelected ? .orange : .white)
                                }
                                
                                Rectangle()
                                    .fill(Color.orange)
                                    .frame(height: 2)
                                    .padding(.top, 45) // Adjust the padding to align the thin line with the selected button
                                    .opacity(latestNewsSelected ? 1 : 0)
                            }
                            
                            Spacer()
                            
                            ZStack {
                                Button(action: {
                                    allNewsSelected.toggle()
                                    latestNewsSelected = false // Deselect the "Latest news" button
                                }) {
                                    Text("All news")
                                        .font(.title2)
                                        .bold()
                                        .padding(10)
                                        .padding(.trailing, 30)
                                        .foregroundColor(allNewsSelected ? .orange : .white)
                                }
                                
                                Rectangle()
                                    .fill(Color.orange)
                                    .frame(height: 2)
                                    .padding(.top, 45) // Adjust the padding to align the thin line with the selected button
                                    .opacity(allNewsSelected ? 1 : 0)
                            }
                        }
                        .background(Color.gray)
                    

                    VStack { // Move the NavigationView inside a VStack
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(viewModel.articles, id: \.heading) { article in
                                    NavigationLink(
                                        destination: ArticleView(article: article),
                                        tag: article,
                                        selection: $selectedArticle
                                    ) {
                                        HStack {
                                            VStack{
                                                Text(article.heading)
                                                    .font(.title)
                                                    .bold()
                                                    .padding(.leading, 10)
                                                
                                                Text(article.relativeDate)
                                                    .padding(.trailing, 130)


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
                viewModel.getArticleFeed()
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


struct InitialMenuActivationModifier: ViewModifier {
    @Binding var isMenuActive: Bool
    @State private var isFirstAppearance = true
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                // Delay the initial activation of the menu only on the first appearance
                if isFirstAppearance {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isMenuActive = false
                        isFirstAppearance = false
                    }
                }
            }
    }
}



struct MenuView: View {
    @Binding var isMenuActive: Bool
    @State private var isProfileActive = false
    
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Button(action: {
                    isProfileActive = true
                    isMenuActive = false // Close the menu
                }) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .onTapGesture {
                    isProfileActive = true // Activate the profile view
                }
                
                NavigationLink(
                    destination: AmusementView()
                ) {
                    HStack {
                        Text("Nöje")
                            .font(.title)
                            .bold()
                            .padding(.leading, 10)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(
                    destination: SportsView()
                ) {
                    HStack {
                        Text("Sport")
                            .font(.title)
                            .bold()
                            .padding(.leading, 10)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(
                    destination: ForeignView()
                ) {
                    HStack {
                        Text("Utrikes")
                            .font(.title)
                            .bold()
                            .padding(.leading, 10)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    isMenuActive = false // Close the menu
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(.top, 80)
                }
            }
            .padding()
        }
        .fullScreenCover(isPresented: $isProfileActive) {
            NavigationView {
                ProfileView()
                    .navigationBarItems(leading: Button(action: {
                        isProfileActive = false // Dismiss the profile view
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.black)
                    })
            }
        }
    }
}






struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}

