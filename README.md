# TMDB-Practice
TMDB Practice

Missing AuthenticationService class intentionally
Replace ***** Get a token from TMDB ***** with your own token from TMDB site

```swift
class AuthenticationService {
    var token: String? = nil
    
    var authenticationHeaders: [String: String] {
        return ["Authorization": "Bearer \(token ?? "")", "accept": "application/json"]
    }
    
    static let shared = AuthenticationService()
    
    private init() {}
    
    func authentcate() {
        self.token = *** Get a token from TMDB ***
    }
}

```
