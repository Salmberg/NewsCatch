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
    @State var isAddArticle = false
    var auth = FirebaseAuth.Auth.self
    var user = Auth.auth().currentUser
    @State private var username = ""
  

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

                        VStack(spacing: 10) {
                            KFImage(URL(string: "https://firebasestorage.googleapis.com:443/v0/b/newscatch-94592.appspot.com/o/swift.jpg?alt=media&token=f0629957-9d7d-4faa-9a10-1288f3d1e870"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 120)
                                .cornerRadius(90)
                                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
                                .padding(.top, 60)
                                .padding(.bottom, 30)

                            VStack(spacing: 10) {
                               Text(username)
                             .font(.system(size: 20))
                                Text(user?.email ?? "")
                                .font(.system(size: 20))
                                .padding(.bottom, 30)
                            }
                        }
                        .background(Color.gray)

                        ZStack {
                            VStack {
                                Text("MINA ARTIKLAR")
                                    .font(.system(size: 25))
                                    .padding(.trailing, 20)
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
                                    VStack {
                                        NavigationLink(destination: MyArticlesView()) {
                                            HStack {
                                                Text("Se fler")
                                                    .font(.title)
                                                    .bold()
                                            }
                                        }
                                        .buttonStyle(BorderedProminentButtonStyle())
                                        .padding(15)
                                    }
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(15)
                            .frame(width: UIScreen.main.bounds.width * 0.98)

                        }
                        .padding(20)
                        .background(Color.gray)

                        ZStack {
                            VStack() {
                                Text("MINA FAVORIT")
                                    .font(.system(size: 25))
                                    .bold()
                                Text("SKRIBENTER")
                                    .font(.system(size: 25))
                                    .bold()
                                HStack {
                                    VStack {
                                        Image(systemName: "person.crop.circle.fill")
                                            .font(.system(size: 80))
                                            .padding(15)
                                        Text("Skribent 1")
                                            .font(.system(size: 15))
                                    }
                                    VStack {
                                        Image(systemName: "person.crop.circle.fill")
                                            .font(.system(size: 80))
                                            .padding(15)
                                        Text("Skribent 2")
                                            .font(.system(size: 15))
                                    }

                                }
                                VStack {
                                    NavigationLink(destination: MyFavouriteAuthorsView()) {
                                        HStack {
                                            Text("Se fler")
                                                .font(.title)
                                                .bold()
                                        }
                                        .padding(.bottom, 20)
                                    }
                                    .buttonStyle(BorderedProminentButtonStyle())
                                    .padding(15)
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(15)
                        }
                        .padding(20)
                        .background(Color.gray)

                        ZStack {
                            VStack {
                                Text("FAVORIT ARTIKLAR")
                                    .font(.system(size: 25))
                                    .padding(.trailing, 20)
                                    .bold()
                                VStack {
                                    HStack {
                                        //Remove these dummy images when real data is used
                                        Image("OldTrafford")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(10)
                                            .padding()
                                        Image("lax")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(10)
                                            .padding()
                                    }
                                    VStack {
                                        NavigationLink(destination: MyArticlesView()) {
                                            HStack {
                                                Text("Se fler")
                                                    .font(.title)
                                                    .bold()
                                            }
                                            .padding(.bottom, 20)
                                        }
                                        .buttonStyle(BorderedProminentButtonStyle())
                                        .padding(15)
                                    }
                                }

                            }
                            .background(Color.white)
                            .cornerRadius(15)
                        }
                        .padding(20)
                        .background(Color.gray)

                        Spacer()
                    }
                }
                .background(Color.gray)
                .ignoresSafeArea()

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
    private func fetchUsername() {
            
            guard let uid = user?.uid else { return }
            
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(uid)
            
            userRef.getDocument { document, error in
                if let document = document, document.exists {
                    let data = document.data()
                    username = data?["username"] as? String ?? ""
                }
            }
        }
}




struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
