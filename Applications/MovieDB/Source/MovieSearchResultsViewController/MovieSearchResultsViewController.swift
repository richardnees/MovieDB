import UIKit
import MovieDBCore
import MovieDBKit

class MovieSearchResultsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSourceController = DataSourceController()
    }
    
    var dataSourceController = DataSourceController() {
        didSet {
            
            tableView.reloadData()
            
            dataSourceController.tableView = tableView
                        
            dataSourceController.errorHandler = { error in
                // FIXME: Handle error
                print(error)
            }
            
            dataSourceController.updateHandler = {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
        
    var query: String = "" {
        didSet {
            if !query.isEmpty {
                let dataSourceProvider = MovieSearchResultDataSourceProvider()
                dataSourceProvider.request = MovieSearchRequest(query: query)
                dataSourceController.provider = dataSourceProvider
                dataSourceController.update()
            }
        }
    }
}
