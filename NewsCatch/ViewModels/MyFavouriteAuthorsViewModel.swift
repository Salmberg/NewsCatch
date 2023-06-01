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
    @Published var MyAuthor = [Article]()
    @Published var users = [User]()
    
    var username = String()
    
    func getMyFavouriteAuthorsFomDB(){
        MyAuthor.removeAll()
        db.collection("PublishedArticles").addSnapshotListener() {
            snapshot, error in
            
            guard let snapshot = snapshot else {return}
            if let error = error {
                print("Error listning to FireStore \(error)")
            }else{
                for document in snapshot.documents{
                    do{
                        let author = try document.data(as: Article.self)
                       
                        self.MyAuthor.append(author)
                    }catch{
                        print("Error reading from FireStore")
                    }
                            
                }
            }
        }
    }
    
    func setFavouriteAuthor(){
            let currentUserID = Auth.auth().currentUser?.uid ?? "unknown"
            db.collection("users").document(currentUserID).getDocument { (document, error) in
                if let document = document, document.exists {
                    self.username = document.get("username") as? String ?? "unknown"
                } else {
                    print("Username not found")
                }
            }
        }
    /*
    func saveFavouriteAuthor(author: User){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var authUser = Auth.auth().currentUser
        var users = getUsersFromDb()
  
            
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
                        "name": users[0].first,
                        "Image": users[0].pictureURL
                        
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
    
     */
    func getUsersFromDb(){
        users.removeAll()
        var user = Auth.auth().currentUser
        db.collection("PublishedArticles").addSnapshotListener() {
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
        
    }
    
}

