//
//  SportsNewsViewModel.swift
//  NewsApp
//
//  Created by Linda Bergsängel on 2023-05-22.
//

import Foundation
import Firebase

class SportsViewModel: ObservableObject{
    
    let db = Firestore.firestore()
    @Published var sportsArticles = [Article]()
    
    func getArticlesFromDb(){
        sportsArticles.removeAll()
        db.collection("PublishedArticles").whereField("category", isEqualTo: "sports").addSnapshotListener() {
                snapshot, error in
                
                guard let snapshot = snapshot else {return}
                if let error = error {
                    print("Error listning to FireStore \(error)")
                }else{
                    for document in snapshot.documents{
                        do{
                            let article = try document.data(as: Article.self)
                            self.sportsArticles.append(article)
                        }catch{
                            print("Error reading from FireStore")
                        }
                    }
                    
                }
            }
    }
}
