//
//  AuthenticationService.swift
//  Practice
//
//  Created by Paul Ancajima on 11/16/23.
//

import Foundation

class UserSession: ObservableObject {
    @Published var accessToken: String? = nil
    @Published var errorShow: Bool = false
    @Published var errorString: String = ""
    var userConfiguration: UserConfigResponse?
    let authenticationService = AuthenticationService.shared
    let networkService = NetworkService()
    init() {
        self.userAuthenticate()
        Task {
            await self.fetchConfigurations()
        }
        
    }
    func userAuthenticate() {
        authenticationService.authentcate()
    }
    func fetchConfigurations() async {
        do {
            guard let url = URL(string: "https://api.themoviedb.org/3/configuration") else { throw URLError(.badURL) }
            let request = URLRequest(url: url)
            let userConfiguration: UserConfigResponse = try await networkService.cachedNetwork(request: request)
            self.userConfiguration = userConfiguration
        } catch {
            errorShow = true
            errorString = error.localizedDescription
        }
    }
}

struct UserConfigResponse: Codable {
    let images: ImagesResponse
}
struct ImagesResponse: Codable {
    let base_url: String
    let poster_sizes: [String]
}


