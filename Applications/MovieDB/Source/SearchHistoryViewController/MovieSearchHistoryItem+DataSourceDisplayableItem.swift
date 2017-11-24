import Foundation
import MovieDBCore

extension MovieSearchHistoryItem: DataSourceItemProtocol {
    public var cellIdentifier: String {
        return String(describing: SearchHistoryCell.self)
    }
}
