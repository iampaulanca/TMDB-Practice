//
//  AuthenticationService.swift
//  Practice
//
//  Created by Paul Ancajima on 11/16/23.
//

import Foundation

class AuthenticationService {
    var token: String? = nil
    
    var authenticationHeaders: [String: String] {
        return ["Authorization": "Bearer \(token ?? "")", "accept": "application/json"]
    }
    
    static let shared = AuthenticationService()
    
    private init() {}
    
    func authentcate() {
        self.token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MjZhN2ZlYWQ2M2EyZTNkNDNjNGYyZjAxZDQ0MTNlMyIsInN1YiI6IjU4MmI5NWQxOTI1MTQxMTFhZjAwMDAzOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.CDY8V5Nc6xXsmu998hAhA3fD5qlJatN_MH9ReIWFZHA"
    }
}
