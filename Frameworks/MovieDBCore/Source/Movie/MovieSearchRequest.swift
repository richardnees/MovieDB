import Foundation

public class MovieSearchRequest {
    public var query: String
    public var page: Int
    
    public init(query: String, page: Int = 1) {
        self.query = query
        self.page = page
    }
}

extension MovieSearchRequest: Request {
    public var urlComponents: URLComponents {
        var urlComponents = API.baseURLComponents
        urlComponents.path = "/3/search/movie"
        urlComponents.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
        urlComponents.queryItems?.append(URLQueryItem(name: "query", value: query))
        return urlComponents
    }
}
