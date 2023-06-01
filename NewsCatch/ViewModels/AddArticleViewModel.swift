//
//  AddArticleViewModel.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//
import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class AddArticleViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    @Published var articles = [Article]()
    @Published var titleContent: String = "Enter Title..."
    @Published var textContent: String = "Enter your article text here..."
    @Published var categoryContent: Category = Category.unspecified // Actual category
    @Published var categoryString: String = "Unspecified" // String for drop-down menu
    @Published var pictureURLL: String?
    @Published var username: String
    
    // Message for the posting alert pop-up
    let alertMessage = "Thank you for your submission. Your article will soon be inspected by an admin. If approved, it will be published for other users to see."
    
    init() {
        self.username = "unknown"
        updateUsername()
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
    
    func setCategory(cat: Category) {
        categoryContent = cat
        if cat == Category.sports { categoryString = "Sports" }
        if cat == Category.foreign { categoryString = "Foreign" }
        if cat == Category.amusement { categoryString = "Amusement" }
    }
    
    func requestArticle() {

        let newArticle = Article(heading: titleContent, content: textContent, writer: username, pictureURL: pictureURLL, category: categoryContent)
        
        // Upload to Firebase
        do {
            try db.collection("RequestedArticles").addDocument(from: newArticle)
        } catch {
            print("Error sending to Database")
        }
    }
    
    func uploadImage(_ image: UIImage) {
        // Convert the image to data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        // Create a unique filename for the image
        let filename = UUID().uuidString + ".jpg"
        
        // Create a storage reference
        let storageRef = Storage.storage().reference().child("article_images/\(filename)")
        
        // Upload the image data
        let uploadTask = storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                // Handle the upload error
                print("Image upload error: \(error.localizedDescription)")
            } else {
                // Get the download URL for the uploaded image
                storageRef.downloadURL { url, error in
                    if let error = error {
                        // Handle the download URL error
                        print("Download URL error: \(error.localizedDescription)")
                    } else if let downloadURL = url {
                        // Image uploaded successfully, update the article with the image URL
                        self.pictureURLL = downloadURL.absoluteString
                        
                        // Request the article
                        self.requestArticle()
                    }
                }
            }
        }
        
        // You can observe the upload progress or handle completion/failure here if needed
        // uploadTask.observe...
    }
    
    func AproveArticle(article: Article) {
        do {
            try db.collection("PublishedArticles").addDocument(from: article)
            if let id = article.id {
                db.collection("RequestedArticles").document(id).delete()
            }
            
        } catch {
            print("Error sending to Database")
        }
        
    }
    
    func listenToFireStore() {
        db.collection("RequestedArticles").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            if let error = error {
                print("Error listening to Firestore \(error)")
            } else {
                self.articles.removeAll()
                for document in snapshot.documents {
                    do {
                        let article = try document.data(as: Article.self)
                        self.articles.append(article)
                    } catch {
                        print("Error reading from Firestore")
                    }
                }
            }
        }
    }
    
    func delete(index: Int) {
        let article = articles[index]
        if let id = article.id {
            db.collection("RequestedArticles").document(id).delete()
        }
    }
}
