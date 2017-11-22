import Foundation
import MovieDBCore
import MovieDBKit

class MovieSearchHistoryCell: UITableViewCell, DataSourceDisplayableCell {
    var item: DataSourceDisplayableItem? {
        didSet {
            guard let item = item as? MovieSearchHistoryItem else { return }
            
            textLabel?.text = item.query
        }
    }
}
