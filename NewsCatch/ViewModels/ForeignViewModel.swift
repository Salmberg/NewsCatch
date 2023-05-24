//
//  ForeignNewsViewModel.swift
//  NewsApp
//
//  Created by Linda Bergsängel on 2023-05-23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class ForeignViewModel: ObservableObject{
    
    let db = Firestore.firestore()
    @Published var foreignArticles = [Article]()
    
    func articleMockData() {
        let article1 = Article(heading: "ForeignArticle 1", content: "This is the content of foreign article 1.", category: "foreign")
        let article2 = Article(heading: "ForeignArticle 2", content: "This is the content of foreign article 2.", category: "foreign")
        let article3 = Article(heading: "ForeignArticle 3", content: "This is the content of foreign article 3.", category: "foreign")
        
        foreignArticles = [article1, article2, article3]
    }
    
    
    func getArticlesFromDb(){
        foreignArticles.removeAll()
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
                        self.foreignArticles.append(article)
                        
                    }
                } catch {
                    print("Error decoding documents: \(error)")
                }
            }
        }
    }
}
