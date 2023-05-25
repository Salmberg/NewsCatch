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
    
    /*
    func articleMockData() {
        let article1 = Article(heading: "SportsArticle 1", content: "This is the content of sports article 1.", category: "Sports")
        let article2 = Article(heading: "SportsArticle 2", content: "This is the content of sports article 2.", category: "Sports")
        let article3 = Article(heading: "SportsArticle 3", content: "This is the content of sports article 3.", category: "Sports")

        sportsArticles = [article1, article2, article3]
        }
    */
    
    func getArticlesFromDb(){
        sportsArticles.removeAll()
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
                        self.sportsArticles.append(article)
                        
                    }
                } catch {
                    print("Error decoding documents: \(error)")
                }
            }
        }
    }
}
