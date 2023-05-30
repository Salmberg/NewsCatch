//
//  RegisterView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        VStack{
            VStack{
                Rectangle().fill().background(Color.black)
                    .frame(height: 180)
            }
            Text("Register for NewsApp")
                .foregroundColor(Color.white)
                .font(.system(size: 30))
            
            Form{
                TextField("Full name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                TextField("Email address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                NAButton(title: "Create account", background: .blue){
                    viewModel.register()
                }
            }
        }
        .background(Color.black)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
