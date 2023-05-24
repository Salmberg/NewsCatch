//
//  NewsFeedViewModel.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewsFeedViewModel : ObservableObject {
    let db = Firestore.firestore()
    @Published var heading = ""
    @Published var content = ""
    @Published var image = UIImage?.self
    @Published var articles: [Article] = []  //En tom lista som håller artiklarna
    
    
   
    
    func getArticleFeed() {
      
        db.collection("PublishedArticles").addSnapshotListener() {
                snapshot, error in
                
                guard let snapshot = snapshot else {return}
                if let error = error {
                    print("Error listning to FireStore \(error)")
                }else{
                    self.articles.removeAll()
                    for document in snapshot.documents{
                        do{
                            let article = try document.data(as: Article.self)
                            self.articles.append(article)
                        }catch{
                            print("Error reading from FireStore")
                        }
                    }
                    
                }
            }
    }
}
