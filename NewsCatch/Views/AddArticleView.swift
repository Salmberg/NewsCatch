//
//  AddArticleView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI

struct AddArticleView: View {
    @StateObject var viewModel = AddArticleViewModel()
    let lists = ArticleLists()
    //For alert-popup
    @State var showingAlert = false
    
    var body: some View {
            VStack{
                TextEditor(text: $viewModel.titleContent).padding(30).background(Color(red: 240/255, green: 240/255, blue: 245/255))
                    .frame(height: 100)
                TextEditor(text: $viewModel.textContent).padding(30).background(Color(red: 240/255, green: 240/255, blue: 245/255))
                Button("Publish", action: {viewModel.requestArticle()
                    showingAlert = true
                }
                ).alert(viewModel.alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .background(Color(red: 240/255, green: 240/255, blue: 245/255))
        
    }
}

struct AddArticleView_Previews: PreviewProvider {
    static var previews: some View {
        AddArticleView()
    }
}
