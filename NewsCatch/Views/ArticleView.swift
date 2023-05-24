//
//  ArticleView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI

struct ArticleView: View {
    var article: Article
    @Environment(\.presentationMode) var presentationMode // Access the presentation mode
    
    var body: some View {
        VStack {
            Text(article.heading)
                .font(.title)
                .padding()
            
            Text(article.content)
                .padding()
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true) // Hide the default back button
        .navigationBarItems(leading: // Add a custom back button
            Button(action: {
                presentationMode.wrappedValue.dismiss() // Dismiss the ArticleView
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black) // Set the color of the back arrow
            }
        )
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleArticle = Article(heading: "Sample Article", content: "This is a sample article content.", category: "Sports")
        return ArticleView(article: sampleArticle)
    }
}
