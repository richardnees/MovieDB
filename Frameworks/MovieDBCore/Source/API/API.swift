import Foundation

struct API {
    static let defaultQueryItems: [URLQueryItem] = {
        return [
            URLQueryItem(name: "api_key", value: "2696829a81b1b5827d515ff121700838")
        ]
    }()
    
    static let baseURLComponents: URLComponents = {
        var baseURLComponents = URLComponents()
        baseURLComponents.scheme = "https"
        baseURLComponents.host = "api.themoviedb.org"
        baseURLComponents.queryItems = API.defaultQueryItems
        return baseURLComponents
    }()

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }()

    static let dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.formatted(API.dateFormatter)
}
