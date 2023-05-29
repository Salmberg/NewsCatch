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
                    Spacer()
                    Text("Hej användarnamn")
                        .font(.system(size: 30))
                        .padding(.trailing, 20)
                }
                .background(Color.gray)
                HStack{
                    VStack{
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 80))
                            .padding(.leading, 20)
                    
                            Button(action: {
                                do{
                                    //Method for changing picture
                                } catch let changeImageError as NSError {
                                    print("Error changing profile image: %@", changeImageError)
                                }
                            }){
                                Text("Byt bild")
                            }
                    }
                    Spacer()
                    VStack{
                        Text("Ditt användarnamn")
                            .font(.system(size: 20))
                            .padding(.trailing, 20)
                        Text("Din epost")
                            .font(.system(size: 20))
                            .padding(.trailing, 20)
                        }
                    
                    }
                    .background(Color.gray)
                HStack{
                    
                    Button(action: {
                        isAddArticle = true
                    }, label: {
                        Image(systemName: "note.text.badge.plus")
                            .font(.system(size: 35))
                            .padding(.leading, 25)
                            .foregroundColor(Color.green)
                    })
                    .sheet(isPresented: $isAddArticle){
                        AddArticleView()
                    }
                    
                    Image(systemName: "heart.text.square.fill")
                        .font(.system(size: 35))
                        .padding(.leading, 25)
                    Image(systemName: "person.text.rectangle.fill")
                        .font(.system(size: 35))
                        .padding(.leading, 25)
                    Image(systemName: "calendar.badge.clock")
                        .font(.system(size: 35))
                        .padding(.leading, 25)
                    
                }
                VStack{
                                       
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
                
                VStack{
                    Text("MINA ARTIKLAR")
                        .font(.system(size: 30))
                        .padding(.trailing, 20)
                    VStack{
                        Text("MINA FAVORIT SKRIBENTER")
                            .font(.system(size: 30))
                            .padding(.trailing, 20)
                        HStack{
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 80))
                                .padding(.leading, 20)
                            Text("Favourite author")
                                .font(.system(size: 20))
                                .padding(.leading, 20)
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 80))
                                .padding(.leading, 20)
                            Text("Favourite author")
                                .font(.system(size: 20))
                                .padding(.leading, 20)
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 80))
                                .padding(.leading, 20)
                            Text("Favourite author")
                                .font(.system(size: 20))
                                .padding(.leading, 20)
                        }
                    }
                    .padding(.top, 30)
                    VStack{
                        Text("FAVORIT ARTIKLAR")
                            .font(.system(size: 30))
                            .padding(.trailing, 20)
                        HStack{
                            Spacer()
                            NavigationLink(
                                destination: MyFavouriteArticles()
                            ) {
                                HStack {
                                    Text("Se fler")
                                        .font(.title)
                                        .bold()
                                        .padding(.leading, 10)
                                }
                            }
                            .buttonStyle(BorderedProminentButtonStyle())
                            .padding(.trailing, 15)
                        }
                        
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
