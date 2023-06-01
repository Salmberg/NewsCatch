//
//  ProfileView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State var isAddArticle = false
    @State var isSaved = false
    var body: some View {
        VStack{
            HStack {
                Text("Profile")
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 50)

                Spacer()

                Button(action: {
                    do {
                        try Auth.auth().signOut()
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.black)
                }
                .padding(.trailing, 30)
                
            }
            Spacer()
            HStack{
                Button(action: {
                    isAddArticle = true
                }, label: {
                    Text("Add article")
                        .frame(width: 120, height: 42)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                })
                //.offset(x: -130, y: -200)
                .sheet(isPresented: $isAddArticle){
                    AddArticleView()
                }
                .padding(.bottom, 40)
            }
           
            Button(action: {
                isSaved = true
            }, label: {
                Text("Saved Articles")
                    .frame(width: 120, height: 42)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
            })
            //.offset(x: -130, y: -200)
            .sheet(isPresented: $isSaved){
                SavedArticlesView()
            }
            Spacer()
           
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
