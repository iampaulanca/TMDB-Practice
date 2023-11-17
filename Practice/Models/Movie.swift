//
//  Movie.swift
//  Practice
//
//  Created by Paul Ancajima on 11/16/23.
//

import Foundation

struct Movie: Codable {
    let id: String
    let title: String
    let genre: String
    let releaseDate: String
    let actors: [MovieActor]
    let images: [String]
}
