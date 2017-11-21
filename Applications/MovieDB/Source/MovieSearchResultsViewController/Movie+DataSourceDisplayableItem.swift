import Foundation
import MovieDBCore
import MovieDBKit

extension Movie: DataSourceDisplayableItem {
    public var cellIdentifier: String {
        return String(describing: MovieSearchResultCell.self)
    }
}
