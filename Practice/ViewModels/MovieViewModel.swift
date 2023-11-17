//
//  MovieViewModel.swift
//  Practice
//
//  Created by Paul Ancajima on 11/15/23.
//

import Foundation
import Combine
import UIKit

class MovieViewModel: ObservableObject {
    let networkService: NetworkService
    let userSession: UserSession
    @Published var errorString = ""
    @Published var errorShow = false
    @Published var movies: [RealMovie] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(userSession: UserSession, networkService: NetworkService) {
        self.networkService = networkService
        self.userSession = userSession
        
        userSession.$errorShow
            .receive(on: DispatchQueue.main)
            .sink { show in
            self.errorShow = show
        }.store(in: &cancellables)
        
        userSession.$errorString
            .receive(on: DispatchQueue.main)
            .sink { message in
            self.errorString = message
        }.store(in: &cancellables)
    }
    
    @MainActor
    func fetchMovies(title: String, _ params: [URLQueryItem] = []) async {
        do {
            var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/search/movie")
            let movieQueryItem = URLQueryItem(name: "query", value: title)
            var defaultParams: [URLQueryItem] = [movieQueryItem]
            defaultParams.append(contentsOf: params)
            urlComponents?.queryItems = defaultParams
            guard let url = urlComponents?.url else { throw URLError(.badURL) }
            let request = URLRequest(url: url)
            let realMovieResponse: RealMovieResponse = try await networkService.cachedNetwork(request: request)
            self.movies = realMovieResponse.results
        } catch {
            errorShow = true
            errorString = error.localizedDescription
        }
    }
    
    // We would need to use this if we didn't have AsyncImage
    func fetchImage(posterPath: String) async -> UIImage {
        do {
            guard let urlString = userSession.userConfiguration?.images.base_url,
                  let url = URL(string: urlString + posterPath) else { throw URLError(.badURL) }
            let request = URLRequest(url: url)
            let image = try await networkService.cachedNetworkImage(request: request)
            return image
        } catch {
            self.errorShow = true
            self.errorString = error.localizedDescription
            return UIImage(systemName: "wifi.slash")!
        }
    }
}
