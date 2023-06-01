//
//  MyFavouriteArticlesViewModel.swift
//  NewsCatch
//
//  Created by Linda Bergsängel on 2023-06-01.
//

import Foundation
import Firebase

class MyFavouriteArticlesViewModel: ObservableObject {
    
    @Published var favouriteArticles = [Article]()
    let db = Firestore.firestore()
    
    func getArticlesFromDb(){

        favouriteArticles.removeAll()
            db.collection("PublishedArticles").addSnapshotListener() {
                snapshot, error in
                
                guard let snapshot = snapshot else {return}
                if let error = error {
                    print("Error listning to FireStore \(error)")
                }else{
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
