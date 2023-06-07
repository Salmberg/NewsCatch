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
        
        MyAuthors.removeAll()
        
        
        let favouriteAuthorsCollection = db.collection("authors")
            .document(uid)
            .collection("favouriteWriters")
        
        favouriteAuthorsCollection.addSnapshotListener() {
            snapshot, error in
            
            guard let snapshot = snapshot else {return}
            
            if let error = error {
                print("Error retrieving favourite authors: \(error)")
                return
            } else{
                for document in snapshot.documents{
                    do{
                        let dbUser = try document.data(as: User.self)
                        self.MyAuthors.append(dbUser)
                    }catch{
                        print("Error reading from FireStore")
                    }
                }
            }
        }
      
    }
    
    
    
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
                                self.users.append(dbUser)
                            }
                        }catch{
                            print("Error reading from FireStore")
                        }
                    }
                    
                    
                    let favouriteAuthorsCollection = self.db.collection("authors")
                        .document(uid)
                        .collection("favouriteWriters")
                    
                    let savedArticlesQuery = favouriteAuthorsCollection
                        .whereField("email", isEqualTo: self.users[0].email)
                        
                    if(self.users.count > 1){return} //hopefully fix double adding bug
                    
                        savedArticlesQuery.getDocuments { snapshot, error in
                            if let error = error {
                                print("Error retrieving saved articles: \(error)")
                                return
                            }
                            
                            if snapshot?.isEmpty == false {
                              
                                print("Author is already saved!")
                            } else {
                                
                                if(!self.users.isEmpty){ //to avoid index out of bounds crash
                                    var data: [String: Any] = [
                                        "username": self.users[0].username,
                                        "imageURL": self.users[0].imageURL,
                                        "name": self.users[0].name,
                                        "email": self.users[0].email,
                                        "joined": self.users[0].joined,
                                        "id": self.users[0].id
                                    ]
                                    
                                    
                                    
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
    
    func removeAuthor(username: String){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        self.MyAuthors.removeAll()
        
        self.db.collection("authors").document(uid).collection("favouriteWriters").whereField("username", isEqualTo: username).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.db.collection("authors")
                        .document(uid)
                        .collection("favouriteWriters").document(document.documentID).delete { error in
                        if let error = error {
                            print("Error deleting author: \(error)")
                        } else {
                            print("Author deleted successfully")
                            self.MyAuthors.removeAll()
                            self.getMyFavouriteAuthors()
                        }
                    }
                }
            }
    }
        
        
    }
    
        
    }

