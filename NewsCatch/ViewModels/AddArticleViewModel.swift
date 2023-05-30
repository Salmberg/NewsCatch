//
//  AddArticleViewModel.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import Foundation
import Firebase
import FirebaseAuth

class AddArticleViewModel: ObservableObject{
    
    let db = Firestore.firestore()
    @Published var articles = [Article]()
    @Published var titleContent : String = "Enter Title..."
    @Published var textContent : String = "Enter your article text here..."
    @Published var categoryContent : Category = Category.unspecified // Actual category
    @Published var categoryString : String = "Unspecified" // String for drop-down menu
    //Current users username
    var username : String
    
    //Message for the posting alert pop-up
    let alertMessage = "Thank you for your submission. Your article will soon be inspected by an admin. If approved, it will be published for other users to see."
    
    init(){
        //temporarily set as unknown
        self.username = "unknown"
        updateUsername()
    }
    
    func setCategory(cat: Category){
            categoryContent = cat
            if(cat == Category.sports){categoryString = "Sports" }
            if(cat == Category.foreign){categoryString = "Foreign" }
            if(cat == Category.amusement){categoryString = "Amusement" }
        }
    
    func requestArticle(){
        
        let newArticle = Article(heading:titleContent, content: textContent, writer: username, category: categoryContent)
        //upload to firebase
        do{
            try db.collection("RequestedArticles").addDocument(from: newArticle)
        } catch{
            print("Error sending to Database")
        }
    }
    
    func updateUsername(){
        let currentUserID = Auth.auth().currentUser?.uid ?? "unknown"
        db.collection("users").document(currentUserID).getDocument { (document, error) in
            if let document = document, document.exists {
                self.username = document.get("username") as? String ?? "unknown"
            } else {
                print("Username not found")
            }
        }
    }
    
    func uploadImage(_ image: UIImage) {
            // Handle the image upload logic
            // You can access the selected image here and perform the necessary operations
        }
    
    func AproveArticle(article: Article){
        do{
            try db.collection("PublishedArticles").addDocument(from: article)
            if let id = article.id{
                db.collection("RequestedArticles").document(id).delete()
            }
            
        } catch{
            print("Error sending to Database")
        }
        
    }
    
    func listenToFireStore(){
                
            db.collection("RequestedArticles").addSnapshotListener() {
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
        
        func delete (index: Int) {
                
                let article = articles[index]
                if let id = article.id{
                    db.collection("RequestedArticles").document(id).delete()
                }
            }
    
    
}
