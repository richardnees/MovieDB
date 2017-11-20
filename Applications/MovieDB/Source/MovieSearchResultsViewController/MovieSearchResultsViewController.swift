import UIKit
import MovieDBCore
import MovieDBKit

class MovieSearchResultsViewController: UITableViewController {

    var dataSource: DataSourceController? {
        didSet {
            
            tableView.reloadData()
            
            guard let dataSource = dataSource else {
                return
            }
            
            dataSource.tableView = tableView
            
            dataSource.errorHandler = { error in
                // FIXME: Handle error
                print(error)
            }
            
            dataSource.updateHandler = {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            dataSource.cancellationHandler = {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
        
    var query: String = "" {
        didSet {
            if !query.isEmpty {
                dataSource?.cancel()
                dataSource = DataSourceController()
                dataSource?.request = MovieSearchRequest(query: query)
                dataSource?.resume()
            }
        }
    }
}

