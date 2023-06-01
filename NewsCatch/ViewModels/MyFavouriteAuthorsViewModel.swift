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
}
