import Foundation
import MovieDBCore

extension MovieSearchHistoryItem: DataSourceDisplayableItem {
    public var cellIdentifier: String {
        return String(describing: MovieSearchHistoryCell.self)
    }
}
