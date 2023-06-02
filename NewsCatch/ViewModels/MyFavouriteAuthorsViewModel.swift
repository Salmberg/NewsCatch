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
    
    func getMyFavouriteAuthorsFomDB(){
        MyAuthors.removeAll()
        db.collection("PublishedArticles").addSnapshotListener() {
            snapshot, error in
            
            guard let snapshot = snapshot else {return}
            if let error = error {
                print("Error listning to FireStore \(error)")
            }else{
                for document in snapshot.documents{
                    do{
                        let author = try document.data(as: User.self)
                       
                        self.MyAuthors.append(author)
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
        var user = Auth.auth().currentUser
        db.collection("users").addSnapshotListener() {
                snapshot, error in
                
                guard let snapshot = snapshot else {return}
                if let error = error {
                    print("Error listning to FireStore \(error)")
                }else{
                    for document in snapshot.documents{
                        do{
                            let dbUser = try document.data(as: User.self)
                            if(dbUser.email == user?.email){
                                self.users.append(dbUser)
                            }
                        }catch{
                            print("Error reading from FireStore")
                        }
                    }
                    
                }
            }
        
        
        
        
        
            
        let favouriteAuthors = db.collection("authors")
                .document(uid)
                .collection("FavouriteAuthors")
        
        let favouriteAuthorsCollection = db.collection("authors")
            .document(uid)
            .collection("FavouriteAuthors")
        
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
            
                    var data: [String: Any] = [
                        "username": self.users[0].username,
                        "Image": self.users[0].imageURL
                        
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

