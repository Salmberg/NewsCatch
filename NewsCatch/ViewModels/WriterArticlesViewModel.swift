//
//  WriterArticlesViewModel.swift
//  NewsCatch
//
//  Created by Viktor on 2023-06-01.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class WriterArticlesViewModel: ObservableObject{
    
    let db = Firestore.firestore()
    @Published var articles = [Article]()
    @Published var sortedArticles = [Article]()
    var username = String()

    func getArticlesFromDb(){
        articles.removeAll()
        db.collection("PublishedArticles").addSnapshotListener() {
                snapshot, error in
                
                guard let snapshot = snapshot else {return}
                if let error = error {
                    print("Error listning to FireStore \(error)")
                }else{
                    for document in snapshot.documents{
                        do{
                            let article = try document.data(as: Article.self)
                            if(article.writer == self.username){
                                self.articles.append(article)
                            }
                        }catch{
                            print("Error reading from FireStore")
                        }
                    }
                    
                }
            }
    }
    
    
}
