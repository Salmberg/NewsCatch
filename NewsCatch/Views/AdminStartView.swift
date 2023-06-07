//
//  AdminView.swift
//  NewsCatch
//
//  Created by Youssef Azroun on 2023-0-5.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseStorage

struct AdminStartView: View {
    @State private var showDeleteArticles = false
    var user = Auth.auth().currentUser
    let db = Firestore.firestore()


    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Image("Image 1") //newsCatchLogo.png
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 210)
                        .clipped()
                        .shadow(color: .white, radius: 10, x: 0, y: 0)
                        .padding([.top, .leading, .trailing], 50)
                        .transformEffect(.identity)
                    
                    Text("Admin")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    Spacer()
                    
                    NavigationLink(destination: AdminView(logInVm: LoginViewModel(), isAdmin: .constant(true))) {
                        Text("Approve Articles")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        showDeleteArticles = true
                    }) {
                        Text("Delete Articles")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Sign-out button clicked")
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
                    .padding(.bottom, 100)

                }
                .fullScreenCover(isPresented: $showDeleteArticles) {
                    AdminDeleteArticles()
                }
            }
        }
    }
}


struct AdminStartView_Previews: PreviewProvider {
    static var previews: some View {
        AdminStartView()
    }
}
