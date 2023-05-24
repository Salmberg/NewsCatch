//
//  AmusementNewsViewModel.swift
//  NewsApp
//
//  Created by Linda Bergsängel on 2023-05-23.
//

import Foundation
import Firebase

class AmusementViewModel: ObservableObject{
    
    let db = Firestore.firestore()
    @Published var amusementArticles = [Article]()
    
    func articleMockData() {
        let article1 = Article(heading: "AmusementArticle 1", content: "This is the content of foreign article 1.", category: "Amusement")
        let article2 = Article(heading: "AmusementArticle 2", content: "This is the content of foreign article 2.", category: "Amusement")
        let article3 = Article(heading: "AmusementArticle 3", content: "This is the content of foreign article 3.", category: "Amusement")

        amusementArticles = [article1, article2, article3]
        }
    
    
    func getArticlesFromDb(){
        amusementArticles.removeAll()
        db.collection("PublishedArticles").getDocuments{ (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                do {
                    guard let querySnapshot = querySnapshot else {
                        print("No documents found")
                        return
                    }
                    
                    for document in querySnapshot.documents {
                        let article = try document.data(as: Article.self)
                        self.amusementArticles.append(article)
                        
                    }
                } catch {
                    print("Error decoding documents: \(error)")
                }
            }
        }
    }
}
