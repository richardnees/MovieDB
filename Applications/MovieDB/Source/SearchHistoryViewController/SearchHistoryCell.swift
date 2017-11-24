import Foundation
import MovieDBCore
import MovieDBKit

class SearchHistoryCell: UITableViewCell, DataSourceCellProtocol {
    
    var item: DataSourceItemProtocol? {
        didSet {
            guard let item = item as? MovieSearchHistoryItem else { return }
            
            textLabel?.text = item.query
            detailTextLabel?.text = SearchHistoryCell.modificationDateFormatter.string(from: item.modificationDate)
        }
    }
    
}

extension SearchHistoryCell {
    
    static let modificationDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()

}
