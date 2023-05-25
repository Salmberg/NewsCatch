//
//  Article.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import Foundation

import FirebaseFirestoreSwift
import UIKit

struct Article : Codable, Identifiable, Hashable{
    @DocumentID var id : String?
    //var id = UUID()
    var heading: String
    var content: String
    var category: Category?
    //var picture: UIImage? // Temporarily commented out to conform to "codable"
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(heading)
       }
    
    
    private var unformattedDate = Date()
    
    init(heading: String, content: String, picture: UIImage? = nil, category: Category?) {
        self.heading = heading
        self.content = content
        self.category = category ?? Category.unspecified //Unspecified if given nothing
        //self.picture = picture // Temporarily commented out to conform to "codable"
        dateFormatter.dateStyle = .medium
    }
    
    var date : String {
        let dateFormatter = DateFormatter()
        return dateFormatter.string(from: unformattedDate)
    }
}
