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
    //For Category label
    @State var catLabel = "Unspecified"
    
    //Needed to be able to "dismiss" the view
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
            VStack{
                TextEditor(text: $viewModel.titleContent).padding(30).background(Color(red: 240/255, green: 240/255, blue: 245/255))
                    .frame(height: 100)
                TextEditor(text: $viewModel.textContent).padding(30).background(Color(red: 240/255, green: 240/255, blue: 245/255))
                Menu { //Not very elegant, should be possible with some for-loop
                    Button {
                        viewModel.setCategory(cat: Category.world)
                        catLabel = viewModel.categoryString
                    } label: {
                        Text("World")
                    }
                    Button {
                        viewModel.setCategory(cat: Category.economy)
                        catLabel = viewModel.categoryString
                    } label: {
                        Text("Economy")
                    }
                    Button {
                        viewModel.setCategory(cat: Category.sports)
                        catLabel = viewModel.categoryString
                    } label: {
                        Text("Sports")
                    }
                    Button {
                        viewModel.setCategory(cat: Category.tech)
                        catLabel = viewModel.categoryString
                    } label: {
                        Text("Tech")
                    }
                    Button {
                        viewModel.setCategory(cat: Category.politics)
                        catLabel = viewModel.categoryString
                    } label: {
                        Text("Politics")
                    }
                    Button {
                        viewModel.setCategory(cat: Category.entertainment)
                        catLabel = viewModel.categoryString
                    } label: {
                        Text("Entertainment")
                    }
                } label: {
                    Image(systemName: "newspaper.circle.fill")
                    Text(catLabel)
                }.padding([.bottom, .trailing], 25)
                Button("Publish", action: {viewModel.requestArticle()
                    showingAlert = true
                }
                ).alert(viewModel.alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {
                        self.presentation.wrappedValue.dismiss() //Dismiss the view
                    }
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
