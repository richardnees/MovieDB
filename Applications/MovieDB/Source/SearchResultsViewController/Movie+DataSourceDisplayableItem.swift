import Foundation
import MovieDBCore
import MovieDBKit

extension Movie: DataSourceItemProtocol {
    public var cellIdentifier: String {
        return String(describing: SearchResultCell.self)
    }
}
