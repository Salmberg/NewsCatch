//
//  Article.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import Foundation
import FirebaseFirestoreSwift
import UIKit

struct Article: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var heading: String
    var content: String
    var category: String
    var date: Date // Add a property to store the creation date and time
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(heading)
    }
    
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

    
    init(heading: String, content: String, picture: UIImage? = nil, category: String) {
        self.heading = heading
        self.content = content
        self.category = category
        self.date = Date() // Set the current date and time during initialization
    }
}

