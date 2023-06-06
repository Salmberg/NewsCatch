//
//  LoginView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//





import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State var isAdmin = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image("Image 1") //newsCatchLogo.png
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 210)
                        .clipped()
                        .shadow(color: .white, radius: 10, x: 0, y: 0)
                        .padding([.top, .leading, .trailing], 50)
                        .transformEffect(/*@START_MENU_TOKEN@*/.identity/*@END_MENU_TOKEN@*/)
                    
                    Rectangle()
                        .foregroundColor(Color.gray)
                        .cornerRadius(1000)
                        .overlay(
                            
                            VStack(spacing: 20) {
                                if !viewModel.errorMessage.isEmpty {
                                    Text(viewModel.errorMessage)
                                        .foregroundColor(Color.red)
                                }
                                    Spacer()
                                
                                TextField("Email Address", text: $viewModel.email)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding(.horizontal, 100.0)
                                    
                                    
                                
                                SecureField("Password", text: $viewModel.password)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal, 100.0)
                                    
                                Image(systemName: "newspaper.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(.white)
                                
                                NAButton(title: "Login", background: Color.black) {
                                    if viewModel.email == "admin@newsfeed.se" && viewModel.password == "12345678" {
                                        isAdmin = true
                                        return
                                        
                                    }
                                    
                                    viewModel.login()
                                    
                                }
                                
                                
                                .frame(maxWidth: .infinity) // Make the button wider
                                .fullScreenCover(isPresented: $isAdmin) {
                                    AdminStartView()
                                }
                                .padding(.horizontal, 100.0)
                                
                               
                                
                                Text("Don't have an account yet?")
                                    .foregroundColor(.white)
                                
                                NavigationLink("Create an account", destination: RegisterView())
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(.bottom, 20)
                            }
                            .padding()
                        )
                    
                    Spacer()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
