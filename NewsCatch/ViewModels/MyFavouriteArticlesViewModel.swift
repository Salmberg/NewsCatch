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
        db.collection("usersaved articles").document(uid).collection("SavedArticles").addSnapshotListener() { snapshot, error in
            self.favouriteArticles.removeAll()
                
                
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
    
    func deleteArticle(_ article: Article) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        if let articleIndex = favouriteArticles.firstIndex(of: article), let articleID = article.id {
            favouriteArticles.remove(at: articleIndex)

            db.collection("usersaved articles").document(uid)
                .collection("SavedArticles").document(articleID).delete { error in
                    if let error = error {
                        print("Error deleting article from Firestore: \(error)")
                    } else {
                        print("Article deleted successfully")
                    }
                }
        }
    }


    }
