//
//  ArticleView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI
import Kingfisher

struct ArticleView: View {
    var article: Article
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            ScrollView {
                if let pictureURL = article.pictureURL {
                    KFImage(URL(string: pictureURL))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                }

                Text(article.heading)
                    .font(.title)
                    .padding()

                Text(Article.dateFormatter.string(from: article.date))
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

//struct ArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleArticle = Article(heading: "Sample Article", content: "This is a sample article content.", pictureURL: "https://example.com/image.jpg", category: Category.unspecified)
//        return ArticleView(article: sampleArticle)
//    }
//}
