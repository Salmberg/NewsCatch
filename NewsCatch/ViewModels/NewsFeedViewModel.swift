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
        
        let savedArticlesQuery = savedArticlesCollection.whereField("uid", isEqualTo: uid)
                                                    .whereField("heading", isEqualTo: article.heading)
        
        savedArticlesQuery.getDocuments { [self] snapshot, error in
            if let error = error {
                print("Error retrieving saved articles: \(error)")
                return
            }
            
            if let document = snapshot?.documents.first {
                // The article is already saved, delete it
                document.reference.delete { error in
                    if let error = error {
                        print("Error deleting article: \(error)")
                    } else {
                        print("Article deleted successfully!")
                    }
                }
            } else {
                // The article is not saved, save it
                var data: [String: Any] = [
                    "uid": uid,
                    "heading": article.heading,
                    // Add other article properties you want to store
                ]
                data["isStarred"] = true  // Update this based on your logic for setting the star status
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
        savedArticlesCollection.whereField("uid", isEqualTo: uid).getDocuments { snapshot, error in
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


}
