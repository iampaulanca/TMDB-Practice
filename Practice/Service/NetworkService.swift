//
//  NetworkService.swift
//  Practice
//
//  Created by Paul Ancajima on 11/15/23.
//

import Foundation
import UIKit

enum CustomError: Error {
    case customErr
    case notAuthenticated
}

extension CustomError {
    var localizedError: String {
        switch self {
        case .customErr:
            return "custom error response"
        case .notAuthenticated:
            return "Not Authenticated"
        }
    }
}

protocol NetworkServiceProtocol {
    func cachedNetwork<T:Codable>(request: URLRequest) async throws -> T
    func cachedNetworkImage(request: URLRequest) async throws -> UIImage
}

class NetworkService: NetworkServiceProtocol {
    
    // Create a URLSession configuration with a custom cache
    var session: URLSession
    let cache = URLCache.shared
    let authenticationService: AuthenticationService
    
    init(authenticationService: AuthenticationService = .shared) {
        self.authenticationService = authenticationService

        // Configure session
        let config = URLSessionConfiguration.default
        config.urlCache = .shared
        config.requestCachePolicy = .returnCacheDataElseLoad

        // Create a URLSession with the custom configuration
        self.session = URLSession(configuration: config)
        
    }
    
    func cachedNetwork<T:Codable>(request: URLRequest) async throws -> T {
        guard authenticationService.token != nil else { throw CustomError.notAuthenticated }
        var request = request
        for (key,value) in authenticationService.authenticationHeaders {
            request.addValue(value, forHTTPHeaderField: key)
        }
        // Perform a data task
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
            
            // Cache the response
            let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
            self.cache.storeCachedResponse(cachedResponse, for: request)
        } else {
            throw CustomError.customErr
        }
        let T = try JSONDecoder().decode(T.self, from: data)
        return T
    }
    
    func cachedNetworkImage(request: URLRequest) async throws -> UIImage {
        guard authenticationService.token != nil else { throw CustomError.notAuthenticated }
        var request = request
        for (key,value) in authenticationService.authenticationHeaders {
            request.addValue(value, forHTTPHeaderField: key)
        }
        // Perform a data task
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
            
            // Cache the response
            let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
            self.cache.storeCachedResponse(cachedResponse, for: request)
        } else {
            throw CustomError.customErr
        }
        
        guard let image = UIImage(data: data) else { throw CustomError.customErr }
        
        return image
    }
    
    
}
