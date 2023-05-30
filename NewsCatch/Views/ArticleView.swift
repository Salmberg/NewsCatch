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
                    .font(.custom("BebasNeue-Regular", size: 30))
                    .padding()
                    .font(.title)
                
                Text(article.content)
                    .font(.custom("CrimsonText-Regular", size: 18))
                    .padding()
                VStack{
                    HStack{
                        Image(systemName: "person")
                        
                        Text(article.writer)
                            .padding()
                    }
                    HStack {
                        Image(systemName: "calendar")
                        
                        Text(Article.dateFormatter.string(from: article.date))
                            .padding()
                    }
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
    }
}


struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleArticle = Article(heading: "Sample Article", content: "This is a sample article content.", writer: "unknown", category: Category.unspecified)
        return ArticleView(article: sampleArticle)
    }
}
