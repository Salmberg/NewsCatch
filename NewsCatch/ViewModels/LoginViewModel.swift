//
//  LoginViewModel.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login(){
        
        guard validate() else{
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if error == nil {
                    // Successful login
                    DispatchQueue.main.async {
                        self?.clearFields()
                    }
                } else {
                    // Failed login
                    self?.errorMessage = "Login failed. Please try again."
                }
            }
        }

         func clearFields() {
            DispatchQueue.main.async {
                self.email = ""
                self.password = ""
            }
            }
            
            private func validate() -> Bool {
                guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
                    errorMessage = "Please fill in all fields."
                    return false
                }
                
                guard email.contains("@") && email.contains(".") else{
                    errorMessage = "Please enter valid email."
                    return false
                }
                return true
            }
        }
