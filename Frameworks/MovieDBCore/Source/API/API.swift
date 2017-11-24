import Foundation

/// Basic API information.
struct API {

    /// Default query items required in requests.
    static let defaultQueryItems: [URLQueryItem] = {
        return [
            URLQueryItem(name: "api_key", value: "2696829a81b1b5827d515ff121700838")
        ]
    }()
    
    /// Base URL components reuired for requests.
    static let baseURLComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.queryItems = API.defaultQueryItems
        return urlComponents
    }()
}
