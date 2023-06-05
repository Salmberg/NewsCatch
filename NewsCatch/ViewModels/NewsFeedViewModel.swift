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
    private var savedArticlesCollection: CollectionReference {
        return db.collection("Userssaved articles").document(Auth.auth().currentUser!.uid).collection("SavedArticles")
        }
    @Published var heading = ""
    @Published var content = ""
    @Published var category = ""
    @Published var image = UIImage?.self
    @Published var articles: [Article] = []  //En tom lista som håller artiklarna
    @Published var savedArticles: [Article] = []
    
    
   
    
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
    
    func saveArticle(_ article: Article) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //let user = 
        
        let savedArticlesCollection = db.collection("usersaved articles")
            .document(uid)
            .collection("SavedArticles")
        
        let savedArticlesQuery = savedArticlesCollection
            .whereField("heading", isEqualTo: article.heading)
        
        savedArticlesQuery.getDocuments { snapshot, error in
            if let error = error {
                print("Error retrieving saved articles: \(error)")
                return
            }
            
            if snapshot?.isEmpty == false {
                // The article is already saved, do not save it again
                print("Article is already saved!")
            } else {
                // The article is not saved, save it
                var data: [String: Any] = [
                    "heading": article.heading,
                    "content": article.content,
                    "pictureURL": article.pictureURL,
                    "writer": article.writer,
                    "date": article.date,
                ]
                
                savedArticlesCollection.addDocument(data: data) { error in
                    if let error = error {
                        print("Error saving article: \(error)")
                    } else {
                        print("Article saved successfully!")
                    }
                }
            }
        }
    }



    func getSavedArticles(completion: @escaping ([Article]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion([])
            return
        }
        
        savedArticlesCollection.getDocuments { snapshot, error in
            if let error = error {
                print("Error retrieving saved articles: \(error)")
                completion([])
                return
            }
            
            var savedArticles: [Article] = []
            
            for document in snapshot?.documents ?? [] {
                if let article = Article(document: document) {
                    savedArticles.append(article)
                }
            }
            
            completion(savedArticles)
        }
    }

    func delete(index: Int) {
        let article = articles[index]
        if let id = article.id {
            db.collection("PublishedArticles").document(id).delete()
        }
    }
    
    func deleteArticle(_ article: Article) {
        let db = Firestore.firestore()
        
        if let articleId = article.id {
            db.collection("PublishedArticles").document(articleId).delete { error in
                if let error = error {
                    print("Error deleting article: \(error)")
                } else {
                    print("Article deleted successfully")
                    // You can also remove the article from the viewModel.articles array
                }
            }
        } else {
            print("Article ID is nil")
        }
    }


    

}
