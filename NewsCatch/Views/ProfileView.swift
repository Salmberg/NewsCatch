//
//  ProfileView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct ProfileView: View {
    @State var isAddArticle = false
    var auth = FirebaseAuth.Auth.self
    var user = Auth.auth().currentUser
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 80))
                        .padding(.leading, 20)
                    Spacer()
                    Text("Your Profile")
                        .font(.system(size: 30))
                        .padding(.trailing, 20)
                }
                VStack{
                    NavigationLink(
                        destination: MyFavouriteArticles()
                    ) {
                        HStack {
                            Text("Mina favorit artiklar")
                                .font(.title)
                                .bold()
                                .padding(.leading, 10)
                        }
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    
                    NavigationLink(
                        destination: MyFavouriteAuthors()
                    ) {
                        HStack {
                            Text("Mina favorit skribenter")
                                .font(.title)
                                .bold()
                                .padding(.leading, 10)
                        }
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                }
                
                NavigationLink(
                    destination: MyArticles()
                ) {
                    HStack {
                        Text("Mina artiklar")
                            .font(.title)
                            .bold()
                            .padding(.leading, 10)
                    }
                }
                .buttonStyle(BorderedProminentButtonStyle())
                
                HStack{
                    Button(action: {
                        isAddArticle = true
                    }, label: {
                        Text("Lägg till artikel")
                            .frame(width: 220, height: 42)
                            .font(.title)
                            .bold()
                            .padding(.leading, 10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .buttonStyle(BorderedProminentButtonStyle())
                    })
                    .sheet(isPresented: $isAddArticle){
                        AddArticleView()
                    }
                }
                
                Spacer()
                
                Spacer()
                Button(action: {
                    do{
                        try Auth.auth().signOut()
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                    
                    
                }){
                    Text("Logout")
                }
            }
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
