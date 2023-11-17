//
//  RealMovie.swift
//  Practice
//
//  Created by Paul Ancajima on 11/16/23.
//

import Foundation

struct RealMovie: Codable {
    let id: Int
    let title: String
    let poster_path: String?
    let genre_ids: [Int]
    let release_date: String?
}
