//
//  MyFavouriteArticlesViewModel.swift
//  NewsCatch
//
//  Created by Linda Bergsängel on 2023-06-01.
//

import Foundation
import Firebase
import FirebaseAuth

class MyFavouriteArticlesViewModel: ObservableObject {
    @Published var favouriteArticles = [Article]()
    let db = Firestore.firestore()
    
    func getArticlesFromDb(){

        guard let uid = Auth.auth().currentUser?.uid else { return }
        print(uid)
        favouriteArticles.removeAll()
        db.collection("usersaved articles").document(uid).collection("SavedArticles").addSnapshotListener() {
                snapshot, error in
                
                guard let snapshot = snapshot else {return}
                if let error = error {
                    print("Error listning to FireStore \(error)")
                }else{
                    print (snapshot.documents.count)
                    for document in snapshot.documents{
                        do{
                            let article = try document.data(as: Article.self)
                                self.favouriteArticles.append(article)
                        }catch{
                            print("Error reading from FireStore")
                        }
                                
                    }
                }
            }
        }
    }
