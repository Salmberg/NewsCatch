//
//  ArticleView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI

struct ArticleView: View {
    var article: Article
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            
            ScrollView {
                Text(article.heading)
                    .font(.title)
                    .padding()
                
                Text(article.content)
                    .padding()
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
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleArticle = Article(heading: "Sample Article", content: "This is a sample article content.")
        return ArticleView(article: sampleArticle)
    }
}
