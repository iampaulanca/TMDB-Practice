//
//  User.swift
//  Practice
//
//  Created by Paul Ancajima on 11/16/23.
//

import Foundation

struct User: Codable {
    let id: String
    let userName: String
    let favoriteMovies: [Movie]
    let joinedDate: Date
}
