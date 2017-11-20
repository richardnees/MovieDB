import Foundation

struct API {
    static let defaultQueryItems: [URLQueryItem] = {
        return [
            URLQueryItem(name: "api_key", value: "2696829a81b1b5827d515ff121700838")
        ]
    }()
    
    static let baseURLComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.queryItems = API.defaultQueryItems
        return urlComponents
    }()

    static let yearMonthDayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }()
}
