//
//  Article.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import Foundation
import FirebaseFirestoreSwift
import UIKit
import FirebaseFirestore


struct Article: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var heading: String
    var content: String
    var category: Category?
    var pictureURL: String? // Temporarily commented out to conform to "codable"
    var date: Date // Add a property to store the creation date and time
    var writer: String //Username of the user who made this article
    var location: String  //Holds the location where the article takes place
    var popularity: Int //How many times the article has been saved by users
    
    
    
    static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .medium
            return formatter
        }()
    

    var relativeDate: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }

    
    init(heading: String, content: String, writer: String, pictureURL: String?, category: Category?, location: String) {
        self.heading = heading
        self.content = content
        self.category = category ?? Category.unspecified //Unspecified if given nothing
        //self.picture = picture // Temporarily commented out to conform to "codable"
        self.date = Date() // Set the current date and time during initialization
        self.pictureURL = pictureURL
        self.writer = writer
        self.location = location
        self.popularity = 0
    }
}

extension Article {
    init?(document: QueryDocumentSnapshot) {
        guard let data = document.data() as? [String: Any] else { return nil }
        guard let heading = data["heading"] as? String else { return nil }
        // Extract other properties based on your Article model from the data dictionary
        
        let content = data["content"] as? String
        let writer = data["writer"] as? String
        let category = data["category"] as? Category
        let location = data["location"] as? String
 
        self.init(heading: heading, content: content ?? "", writer: writer ?? "", pictureURL: nil, category: category, location: location ?? "")
    }
}

