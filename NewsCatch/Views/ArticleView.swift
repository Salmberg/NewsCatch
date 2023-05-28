//
//  ArticleView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct ArticleView: View {
    var article: Article
    @Environment(\.presentationMode) var presentationMode
    @State var retrievedImages = [UIImage]() // Store retrieved images
    
    
    
    
    
    var body: some View {
        VStack {
            ScrollView {
                Text(article.heading)
                    .font(.title)
                    .padding()
                
                Text(Article.dateFormatter.string(from: article.date))
                    .padding()
                
                Text(article.content)
                    .padding()
                
                ForEach(retrievedImages, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
        }
        )
        .onAppear {
            retrievePhotos() // Fetch images when the view appears
        }
    }
    
    func retrievePhotos() {
        // Get the data from the database
        
        
        let db = Firestore.firestore()
        
        db.collection("images").getDocuments { snapshot, error in
            
            if error == nil && snapshot != nil {
                var paths = [String]()
                
                //Loop through all the returned docs
                for doc in snapshot!.documents {
                    
                    // Extract the file path and add to array
                    paths.append(doc["url"] as! String)
                    
                }
                
                // Loop through each file path and fetch the data from storage
                for path in paths {
                    // Get a reference to storage
                    let storageRef = Storage.storage ().reference()
                    
                    // Specify the path
                    let fileRef = storageRef.child(path)
                    
                    // Retrieve the data
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        
                        // Check for errors
                        if error == nil && data != nil {
                            
                            // Create a UIImage and put it into our array for display
                            if let image = UIImage(data: data!){
                                
                                DispatchQueue.main.async {
                                    retrievedImages.append(image)
                                }
                            }
                            
                        }
                    }
                } // end loop through paths
                
            }
        }
    }
    
    
    struct ArticleView_Previews: PreviewProvider {
        static var previews: some View {
            let sampleArticle = Article(heading: "Sample Article", content: "This is a sample article content.", category: Category.unspecified)
            return ArticleView(article: sampleArticle)
        }
    }
}
