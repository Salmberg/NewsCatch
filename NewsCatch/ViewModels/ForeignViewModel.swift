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

    func getArticlesFromDb(){
        foreignArticles.removeAll()
        db.collection("PublishedArticles").addSnapshotListener() {
                snapshot, error in
                
                guard let snapshot = snapshot else {return}
                if let error = error {
                    print("Error listning to FireStore \(error)")
                }else{
                    for document in snapshot.documents{
                        do{
                            let article = try document.data(as: Article.self)
                            if(article.category == Category.foreign){
                                self.foreignArticles.append(article)
                            }
                        }catch{
                            print("Error reading from FireStore")
                        }
                    }
                    
                }
            }    }
}
