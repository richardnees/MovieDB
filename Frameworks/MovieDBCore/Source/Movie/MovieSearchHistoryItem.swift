import Foundation

public struct MovieSearchHistoryItem: Codable {
    public var query: String
    public var modificationDate: Date
    
    public init(query: String) {
        self.query = query
        modificationDate = Date()
    }
}

extension MovieSearchHistoryItem: Equatable {
    public static func ==(lhs: MovieSearchHistoryItem, rhs: MovieSearchHistoryItem) -> Bool {
        return lhs.query == rhs.query
    }
}
