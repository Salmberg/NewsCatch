//
//  User.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
