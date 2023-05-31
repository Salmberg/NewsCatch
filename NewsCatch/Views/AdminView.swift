//
//  AdminView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI
import FirebaseAuth

struct AdminView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = AddArticleViewModel()
    @ObservedObject var logInVm: LoginViewModel
    @Binding var isAdmin: Bool
    
    var body: some View {
        VStack{
            Text("Submitted articles")
                .bold()
                .font(.title)
            List{
                ForEach(viewModel.articles) { article in
                    VStack{
                        Text(article.heading)
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(.red)
                        
                        Spacer()
                        
                        Text(article.content)
                        Spacer()
                        
                        Text("published by: \(article.writer)")
                        Text(" in: \(Article.dateFormatter.string(from: article.date))")
                            .padding()
                        HStack{
                            Spacer()
                            Button(action: {
                                viewModel.AproveArticle(article: article)
                            }, label: {
                                Text("Aprove Article")
                                    .frame(width: 130, height: 30)
                                    .background(.green)
                                    .cornerRadius(15)
                                    .foregroundColor(.white)
                                    .bold()
                            })
                            .buttonStyle(PlainButtonStyle()) // Add this line to remove the default button style
                            Spacer()
                        }
                        .contentShape(Rectangle()) // Add this line to set the button's tap area
                        
                    }
                    .onTapGesture {}
                }
                .onDelete() { IndexSet in
                    for index in IndexSet{
                        viewModel.delete(index: index)
                    }
                    
                }
            }
            Button(action: {
                do {
                    try Auth.auth().signOut()
                    presentationMode.wrappedValue.dismiss()
                    logInVm.email = ""
                    logInVm.password = ""
                } catch let signOutError as NSError {
                    print("Error signing out: \(signOutError.localizedDescription)")
                }
            }) {
                Text("Logout")
            }
            .padding(.vertical)
        }
        
        .onAppear {
            viewModel.listenToFireStore()
        }
        
    }
}

/*struct AdminView_Previews: PreviewProvider {
 static var previews: some View {
 AdminView()
 }
 }*/
