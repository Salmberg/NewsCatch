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
    var body: some View {
        VStack{
            Text("Your Profile")
                .font(.system(size: 30))
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
                .offset(x: -130, y: -200)
                .navigationBarTitle("Add article")
                .sheet(isPresented: $isAddArticle){
                    AddArticleView()
                }
            }
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
