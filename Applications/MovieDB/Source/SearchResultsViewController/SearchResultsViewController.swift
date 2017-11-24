import UIKit
import MovieDBCore
import MovieDBKit

protocol SearchResultsViewControllerDelegate: class {
    func searchResultsViewController(_ searchResultsViewController: SearchResultsViewController, successfullySearchedFor query: String)
    func searchResultsViewController(_ searchResultsViewController: SearchResultsViewController, unsuccessfullySearchedFor query: String)
}

class SearchResultsViewController: UITableViewController {

    // MARK: - Delegate

    weak var delegate: SearchResultsViewControllerDelegate?
    
    // MARK: - Properties

    var query: String = "" {
        didSet {
            if !query.isEmpty {
                dataSourceController = DataSourceController()
                let provider = SearchResultsDataSourceProvider()
                provider.request = MovieSearchRequest(query: query)
                dataSourceController.provider = provider
                dataSourceController.update()
            }
        }
    }

    var selectedMovieIndex: Int = 0
    
    var animatedViewController: UIViewController? {
        didSet {
            guard let animatedViewController = animatedViewController else { return }
            animatedViewController.view.layer.zPosition = -1000
        }
    }

    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // WORKAROUND:
        // Remove the pesky separators in an empty table view
        // https://stackoverflow.com/questions/1633966/can-i-force-a-uitableview-to-hide-the-separator-between-empty-cells
        tableView.tableFooterView = UIView(frame: .zero)
    }
        
    // MARK: - Data Source Controller

    var dataSourceController = DataSourceController() {
        didSet {
            
            dataSourceController.tableView = tableView
            
            dataSourceController.errorHandler = { error in
                let alert = UIAlertController(
                    title: NSLocalizedString("An error occured", comment: "Needs comment"),
                    message: error.localizedDescription,
                    preferredStyle: .alert)
                
                alert.addAction(
                    UIAlertAction(
                        title: NSLocalizedString("OK", comment: "Needs comment"),
                        style: .default,
                        handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
            
            dataSourceController.willUpdate = {
                self.tableView.reloadData()
            }
            
            dataSourceController.didUpdate = {
                if self.dataSourceController.provider.totalItemCount == 0 {
                    self.delegate?.searchResultsViewController(self, unsuccessfullySearchedFor: self.query)
                } else {
                    self.delegate?.searchResultsViewController(self, successfullySearchedFor: self.query)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
