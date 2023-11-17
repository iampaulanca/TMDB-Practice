//
//  Dummies.swift
//  Practice
//
//  Created by Paul Ancajima on 11/16/23.
//

import Foundation

class Dummies {
    static let realMovie = RealMovie(id: 999, title: "", poster_path: nil, genre_ids: [], release_date: "")
    static let userSession = UserSession()
    static let networkService = NetworkService()
    static let movieViewModel = MovieViewModel(userSession: userSession, networkService: networkService)
}
