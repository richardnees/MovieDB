import Foundation
import MovieDBCore
import MovieDBKit

class SearchHistoryCell: UITableViewCell, DataSourceCellProtocol {
    var item: DataSourceItemProtocol? {
        didSet {
            guard let item = item as? MovieSearchHistoryItem else { return }
            
            textLabel?.text = item.query
        }
    }
}
