//
//  AdminView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI
import FirebaseAuth

struct AdminView: View {
    @StateObject var viewModel = AddArticleViewModel()
    var body: some View {
        VStack{
            Text("Submitted articles")
                .bold()
                .font(.title)
            List{
                ForEach(viewModel.articles) { article in
                    VStack{
                        Text(article.heading)
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(.red)
                        
                        Spacer()
                        
                        Text(article.content)
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {
                                viewModel.AproveArticle(article: article)
                            }, label: {
                                Text("Aprove Article")
                                    .frame(width: 130, height: 30)
                                    .background(.green)
                                    .cornerRadius(15)
                                    .foregroundColor(.white)
                                    .bold()
                            })
                            Spacer()
                        }
                        
                    }
                }
                .onDelete() { IndexSet in
                    for index in IndexSet{
                        viewModel.delete(index: index)
                    }
                    
                }
            }
        }
        .onAppear {
            viewModel.listenToFireStore()
        }
        
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
