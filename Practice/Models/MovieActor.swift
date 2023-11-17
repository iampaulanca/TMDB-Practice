//
//  MovieActor.swift
//  Practice
//
//  Created by Paul Ancajima on 11/16/23.
//

import Foundation

struct MovieActor: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let notableMovies: [Movie]
    let images: [String]
}
