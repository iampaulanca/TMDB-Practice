//
//  RealMovieResponse.swift
//  Practice
//
//  Created by Paul Ancajima on 11/16/23.
//

import Foundation

struct RealMovieResponse: Codable {
    let page: Int
    let results: [RealMovie]
}
