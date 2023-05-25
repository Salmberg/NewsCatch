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
        
        NavigationView{
            VStack{
                VStack{
                    Rectangle().fill().background(Color.black)
                        .frame(height: 135)
                }
                Text("Login to news app")
                    .foregroundColor(Color.black)
                    .font(.system(size: 30))
                
                Form{
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    NAButton(title: "Login", background: .green){
                        if viewModel.email == "admin@newsfeed.se" && viewModel.password == "12345678" {
                            isAdmin = true
                            return
                        }
                        viewModel.login()
                        
                    }
                    .navigationBarTitle("Admin View")
                    .fullScreenCover(isPresented: $isAdmin) {
                        AdminView(logInVm: viewModel, isAdmin: $isAdmin)
                    }
                    
                    
                }
                .background(Color(red: 47/255, green:79/255,blue: 79/255))
                
                //Create account
                
                Text("Don't have an account yet?")
                    .foregroundColor(Color.black)
                NavigationLink("Create an account",
                               destination: RegisterView())
            }
            
            
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

