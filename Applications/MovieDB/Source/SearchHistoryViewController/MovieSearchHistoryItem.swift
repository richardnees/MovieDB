import Foundation
import MovieDBCore

struct MovieSearchHistoryItem: Codable {
    var query: String
    var modificationDate: Date
    
    init(query: String) {
        self.query = query
        modificationDate = Date()
    }
}

extension MovieSearchHistoryItem: Equatable {
    static func ==(lhs: MovieSearchHistoryItem, rhs: MovieSearchHistoryItem) -> Bool {
        return lhs.query == rhs.query
    }
}

extension MovieSearchHistoryItem: DataSourceItemProtocol {
    var cellIdentifier: String {
        return String(describing: SearchHistoryCell.self)
    }
}
