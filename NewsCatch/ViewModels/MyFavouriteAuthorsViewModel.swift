//
//  MyArticlesViewModel.swift
//  NewsCatch
//
//  Created by Linda Bergsängel on 2023-06-01.
//

import Foundation
import Firebase

class MyFavouriteAuthorViewModel: ObservableObject{
    
    let db = Firestore.firestore()
    @Published var MyAuthors = [User]()
    @Published var users = [User]()
    
    var username = String()
    
    func getMyFavouriteAuthors() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let favouriteAuthorsCollection = db.collection("writers")
            .document(uid)
            .collection("favouriteWriters")
        
        favouriteAuthorsCollection.getDocuments { snapshot, error in
            if let error = error {
                print("Error retrieving favourite authors: \(error)")
                return
            }
            do{
                for document in snapshot?.documents ?? [] {
                    let user = try document.data(as: User.self)
                    self.MyAuthors.append(user)
                }
            }catch{
                print("Error reading from FireStore")
            }

        }
      
    }
    
    /*func saveFavouriteWriter(userName: String){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let allUsers = [User]()
        
        db.collection("users").addSnapshotListener() {
            snapshot, error in
            
            guard let snapshot = snapshot else {return}
            if let error = error {
                print("Error listning to FireStore \(error)")
            }else{
                for document in snapshot.documents{
                    do{
                        let dbUser = try document.data(as: User.self)
                        if(dbUser.username == userName){
                            allUsers.append(dbUser)
                        }
                    }
                }catch{
                    print("Error reading from FireStore")
                }
                
        // Upload to Firebase
        do {
            try db.collection("users").document(uid).collection("favoriteWriters").addDocument(from: newArticle)
        } catch {
            print("Error sending to Database")
        }
    }*/
    
    
    func saveFavouriteAuthor(userName: String){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var authUser = Auth.auth().currentUser
        users.removeAll()
        
        db.collection("users").addSnapshotListener() {
                snapshot, error in
                
                guard let snapshot = snapshot else {return}
                if let error = error {
                    print("Error listning to FireStore \(error)")
                }else{
                    for document in snapshot.documents{
                        do{
                            let dbUser = try document.data(as: User.self)
                            if(dbUser.username == userName){
                                print(dbUser)
                                self.users.append(dbUser) //append the writer, happens eventually
                            }
                        }catch{
                            print("Error reading from FireStore")
                        }
                    }
                    
                    
                    let favouriteAuthorsCollection = self.db.collection("authors")
                        .document(uid)
                        .collection("favouriteWriters")
                    
                    let savedArticlesQuery = favouriteAuthorsCollection
                        .whereField("email", isEqualTo: authUser?.email)
                        
                        savedArticlesQuery.getDocuments { snapshot, error in
                            if let error = error {
                                print("Error retrieving saved articles: \(error)")
                                return
                            }
                            
                            if snapshot?.isEmpty == false {
                              
                                print("Author is already saved!")
                            } else {
                                
                                if(!self.users.isEmpty){
                                    var data: [String: Any] = [
                                        "username": self.users[0].username, //out of bounds fatal error
                                        "image": self.users[0].imageURL,
                                        "name": self.users[0].name,
                                        "email": self.users[0].email
                                    ]
                                    print("I ACTUALLY HAPPENED")
                                    
                                    
                                    favouriteAuthorsCollection.addDocument(data: data) { error in
                                        if let error = error {
                                            print("Error saving author: \(error)")
                                        } else {
                                            print("Author saved successfully!")
                                        }
                                    }
                                }
                            }
                    
                }
            }

        
            }
        }
        
    }

