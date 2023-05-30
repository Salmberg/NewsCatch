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
            ScrollView{
                ZStack{
                    VStack(spacing: 0){
                        HStack{
                            Spacer()
                            Text("Hej användarnamn")
                                .font(.system(size: 30))
                                .padding(.trailing, 20)
                        }
                        .background(Color.gray)
                        .ignoresSafeArea()
                        HStack(){
                            VStack{
                                FirebaseImage(id: "swift.jpg")
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
                                        .padding(.bottom, 20)
                                        .foregroundColor(Color.black)
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
                                    .padding(20)
                                    .foregroundColor(Color.white)
                            })
                            .sheet(isPresented: $isAddArticle){
                                AddArticleView()
                            }
                            
                            Image(systemName: "heart.text.square.fill")
                                .font(.system(size: 35))
                                .padding(20)
                                .foregroundColor(Color.white)
                            Image(systemName: "person.text.rectangle.fill")
                                .font(.system(size: 35))
                                .padding(20)
                                .foregroundColor(Color.white)
                            Image(systemName: "calendar.badge.clock")
                                .font(.system(size: 35))
                                .padding(20)
                                .foregroundColor(Color.white)
                            
                        }
                        .padding(20)
                        .background(Color(red: 31/255, green:59/255,blue: 77/255))
                        ZStack{
                            VStack{
                                Text("MINA ARTIKLAR")
                                    .font(.system(size: 25))
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
                                    .padding(15)
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(15)
                            .frame(width: UIScreen.main.bounds.width * 0.9)
                            
                        }
                        .padding(20)
                        .background(Color.gray)
                        
                        ZStack{
                            VStack{
                                Text("MINA FAVORIT SKRIBENTER")
                                    .font(.system(size: 25))
                                    .padding(15)
                                HStack{
                                    VStack{
                                        Image(systemName: "person.crop.circle.fill")
                                            .font(.system(size: 80))
                                            .padding(15)
                                        Text("Skribent 1")
                                            .font(.system(size: 15))
                                    }
                                    VStack{
                                        Image(systemName: "person.crop.circle.fill")
                                            .font(.system(size: 80))
                                            .padding(15)
                                        Text("Skribent 2")
                                            .font(.system(size: 15))
                                    }
                                    VStack{
                                        Image(systemName: "person.crop.circle.fill")
                                            .font(.system(size: 80))
                                            .padding(15)
                                        Text("Skribent 3")
                                            .font(.system(size: 15))
                                    }
                                    
                                }
                                HStack{
                                    Spacer()
                                    NavigationLink(
                                        destination: MyFavouriteAuthors()
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
                            .background(Color.white)
                            .cornerRadius(15)
                            .frame(width: UIScreen.main.bounds.width * 0.9)
                        }
                        
                        VStack{
                            Text("FAVORIT ARTIKLAR")
                                .font(.system(size: 25))
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
                        .padding(20)
                        
                        
                        
                        
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
            .background(Color.gray)
            .ignoresSafeArea()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
