import Foundation

/// Use `Poster` to convert `Movie.posterPathComponent` to a `URL`
public struct Poster {
    public enum Size: String {
        case small = "w92"
        case medium = "w185"
        case large = "w500"
        case huge = "w780"
    }
    
    public let path: String

    public init(path: String) {
        self.path = path
    }
}

extension Poster {
    static let baseURLComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "image.tmdb.org"
        urlComponents.path = "/t/p/"
        return urlComponents
    }()
}

extension Poster {
    public func url(for size: Poster.Size) -> URL? {
        return Poster.baseURLComponents.url?
            .appendingPathComponent(size.rawValue)
            .appendingPathComponent(path)
    }
}
