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
    
    var username = String()
    
    func getMyArticlesFomDB(){
        myArticles.removeAll()
        db.collection("PublishedArticles").addSnapshotListener() {
            snapshot, error in
            
            guard let snapshot = snapshot else {return}
            if let error = error {
                print("Error listning to FireStore \(error)")
            }else{
                for document in snapshot.documents{
                    do{
                        let article = try document.data(as: Article.self)
                        print(article.writer)
                        if(article.writer == self.username){
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
