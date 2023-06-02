//
//  MyArticlesViewModel.swift
//  NewsCatch
//
//  Created by Linda Bergsängel on 2023-06-01.
//

import Foundation
import Firebase

class MyArticlesViewModel: ObservableObject{
    
    let db = Firestore.firestore()
    @Published var myArticles = [Article]()
    @Published var users = [User]()
    
    let authUser = Auth.auth().currentUser


    func getMyArticlesFomDB(){
            myArticles.removeAll()
            
        
        db.collection("users").addSnapshotListener() {
                snapshot, error in
                guard let snapshot = snapshot else {return}
                if let error = error {
                    print("Error listning to FireStore \(error)")
                }else{
                    for document in snapshot.documents{
                        do{
                            let user = try document.data(as: User.self)
                            self.users.append(user)
                        }catch{
                            print("Error reading from FireStore")
                        }
                    }
                    
                }
            }
        
        
        
            var dbUser = User(id: " ", name: "test", username: "test", email: "test", joined: Date().timeIntervalSince1970, imageURL: "")
            db.collection("PublishedArticles").addSnapshotListener() {
                snapshot, error in
                for userItem in self.users{
                    if userItem.email == self.authUser?.email{
                        dbUser = userItem
                    }
                }
                guard let snapshot = snapshot else {return}
                if let error = error {
                    print("Error listning to FireStore \(error)")
                }else{
                    for document in snapshot.documents{
                        do{
                            let article = try document.data(as: Article.self)
                            print(article.writer)
                            if(article.writer == dbUser.username){
                                self.myArticles.append(article)
                            }
                        }catch{
                            print("Error reading from FireStore")
                        }
                                
                    }
                }
            }
        }
}
    
