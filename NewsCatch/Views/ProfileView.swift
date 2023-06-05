//
//  ProfileView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI
import FirebaseAuth
import Firebase
import Kingfisher
import FirebaseStorage

struct ProfileView: View {
    let db = Firestore.firestore()
    @State var isAddArticle = false
    var user = Auth.auth().currentUser
    @State var username = "unknown"

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                        }
                        .background(Color.gray)
                        .ignoresSafeArea()

                        VStack{
                            Button(action: {
                                do {
                                    try Auth.auth().signOut()
                                } catch {
                                    print("Failed to sign out: \(error.localizedDescription)")
                                }
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            .padding(.leading, 300)
                            .padding(.top, 50)
                        }

                        VStack(spacing: 10) {
                            KFImage(URL(string: "https://firebasestorage.googleapis.com:443/v0/b/newscatch-94592.appspot.com/o/swift.jpg?alt=media&token=f0629957-9d7d-4faa-9a10-1288f3d1e870"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 120)
                                .cornerRadius(90)
                                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
                                .padding(.top, 60)
                                .padding(.bottom, 30)

                            if let user = Auth.auth().currentUser {
                                let email = user.email ?? ""
                                let displayName = user.displayName ?? ""
                                let profilePictureURL = user.photoURL?.absoluteString ?? ""

                                HStack {
                                    Image(systemName: "at")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                       
                                    Text(email)
                                        .font(.system(size: 20))
                                }
                                HStack{
                                    Image(systemName: "person")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    Text(username)
                                }

                                Text(profilePictureURL)
                            }

                            VStack(spacing: 10) {
                            
                            }
                            .onAppear {
                                updateUsername()
                            }
                        }
                        .background(Color.gray)

                        Button(action: {
                            // Action to perform when the ZStack is clicked
                        }) {
                            NavigationLink(destination: MyArticlesView()) {
                                ZStack {
                                    VStack {
                                        Text("MINA ARTIKLAR")
                                            .font(.system(size: 25))
                                            .foregroundColor(.white)
                                            .padding(.top, 5)
                                            .bold()
                                        VStack {
                                            HStack {
                                                //Remove these dummy images when real data is used
                                                Image("ocean")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(10)
                                                    .padding()
                                                Image("viking")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(10)
                                                    .padding()
                                            }

                                        }
                                        Spacer()
                                    }
                                    .background(Color(red: 31/255, green: 59/255, blue: 77/255))
                                    .cornerRadius(15)
                                    .frame(width: UIScreen.main.bounds.width * 0.98)
                                }
                            }
                        }
                        .padding(20)
                        .background(Color.gray)

                        Button(action: {
                            // Action to perform when the ZStack is clicked
                        }) {
                            NavigationLink(destination:  MyFavouriteArticlesView()) {
                                ZStack {
                                    VStack {
                                        Text("SPARADE ARTIKLAR")
                                            .font(.system(size: 25))
                                            .foregroundColor(.white)
                                            .padding(.top, 5)
                                            .bold()
                                        VStack {
                                            HStack {
                                                //Remove these dummy images when real data is used
                                                Image("ocean")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(10)
                                                    .padding()
                                                Image("viking")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(10)
                                                    .padding()
                                            }

                                        }
                                        Spacer()
                                    }
                                    .background(Color(red: 31/255, green: 59/255, blue: 77/255))
                                    .cornerRadius(15)
                                    .frame(width: UIScreen.main.bounds.width * 0.98)
                                }
                            }
                        }


                        Button(action: {
                            // Action to perform when the ZStack is clicked
                        }) {
                            NavigationLink(destination:  MyFavouriteAuthorsView()) {
                                ZStack {
                                    VStack {
                                        Text("FAVORITSKRIBENTER")
                                            .font(.system(size: 25))
                                            .foregroundColor(.white)
                                            .padding(.top, 10)
                                            .bold()
                                        VStack {
                                            HStack {
                                                VStack{
                                                    Image(systemName: "person.crop.circle.fill")
                                                        .font(.system(size: 80))
                                                        .padding(20)
                                                    Text("Skribent 1")
                                                        .font(.system(size: 15))
                                                }
                                                VStack{
                                                    Image(systemName: "person.crop.circle.fill")
                                                        .font(.system(size: 80))
                                                        .padding(20)
                                                    Text("Skribent 2")
                                                        .font(.system(size: 15))
                                                }
                                            }

                                        }
                                        Spacer()
                                    }
                                    .background(Color(red: 31/255, green: 59/255, blue: 77/255))
                                    .cornerRadius(15)
                                    .frame(width: UIScreen.main.bounds.width * 0.98)

                                }
                            }
                        }
                        .padding(20)
                        .background(Color.gray)

                    }
                }
                .background(Color.gray)
                .ignoresSafeArea(.all)
                .padding(.bottom, 20)



                VStack {
                    Spacer()

                    HStack {
                        Spacer()

                        HStack {
                            Button(action: {
                                isAddArticle = true
                            }, label: {
                                Image(systemName: "note.text.badge.plus")
                                    .font(.system(size: 35))
                                    .padding(20)
                                    .foregroundColor(Color.white)
                            })
                            .sheet(isPresented: $isAddArticle) {
                                AddArticleView()
                            }

                            NavigationLink(destination:
                                SavedArticlesView()) {
                                Image(systemName: "heart.text.square.fill")
                                    .font(.system(size: 35))
                                    .padding(20)
                                    .foregroundColor(Color.white)
                            }

                            NavigationLink(destination: MyFavouriteAuthorsView()) {
                                Image(systemName: "person.text.rectangle.fill")
                                    .font(.system(size: 35))
                                    .padding(20)
                                    .foregroundColor(Color.white)
                            }

                            NavigationLink(destination: ReminderView()) {
                                Image(systemName: "calendar.badge.clock")
                                    .font(.system(size: 35))
                                    .padding(20)
                                    .foregroundColor(Color.white)
                            }
                        }
                        .padding(.bottom, 70)
                        .padding(.leading, 30)
                        .padding(.trailing, 20)

                        .background(Color(red: 31/255, green: 59/255, blue: 77/255))
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 100)
                    }
                }
            }
        }
    }

    func updateUsername() {
        if let user = Auth.auth().currentUser {
            db.collection("users").document(user.uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let username = data?["username"] as? String ?? "unknown"
                    DispatchQueue.main.async {
                        self.username = username
                    }
                } else {
                    print("Document does not exist")
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
