import UIKit
import MovieDBCore
import MovieDBKit


class SearchHistoryViewController: UITableViewController {
    
    // MARK: - Data Source Controller

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
                    self.navigationItem.leftBarButtonItem = nil
                    self.navigationItem.rightBarButtonItem = self.dataSourceController.provider.totalItemCount > 0
                        ? self.editButtonItem
                        : nil
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Search (Results) Controller

    lazy var searchResultsController: SearchResultsViewController = {
        guard let searchResultsController = UIStoryboard(name: String(describing: SearchResultsViewController.self), bundle: nil).instantiateInitialViewController() as? SearchResultsViewController else {
            fatalError("We need a SearchResultsViewController")
        }
        return searchResultsController
    }()
    
    lazy var searchController: UISearchController = {
        return UISearchController(searchResultsController: searchResultsController)
    }()
    
    // MARK: - Button Bar Items
    
    var deleteAllBarButton: UIBarButtonItem {
        let deleteAllBarButton = UIBarButtonItem(
            title: NSLocalizedString("Delete All", comment: "Needs comment"),
            style: .plain,
            target: self,
            action: #selector(deleteAll(_:)))
        return deleteAllBarButton
    }

    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = editButtonItem

        definesPresentationContext = true
        
        dataSourceController = DataSourceController()
        let provider = SearchHistoryProvider()
        dataSourceController.provider = provider
        provider.load()
    }

    // MARK: - Table View Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let item = dataSourceController.provider.items[indexPath.row] as? MovieSearchHistoryItem else { return }
        
        searchController.searchBar.text = item.query
        present(searchController, animated: true) {
            self.searchResultsController.query = item.query
        }
    }
    
    // MARK: - Table View Editing

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        guard dataSourceController.provider.allowsFlush else { return }

        navigationItem.leftBarButtonItem = editing ? deleteAllBarButton : nil
    }
    
    @objc func deleteAll(_ sender: Any) {
        guard dataSourceController.provider.allowsFlush else { return }
        if let provider = dataSourceController.provider as? CodableDataSourceProviding {
            
            let alert = UIAlertController(
                title: NSLocalizedString("Delete All", comment: "Needs comment"),
                message: NSLocalizedString("Are you sure?", comment: "Needs comment"),
                preferredStyle: .actionSheet)
            
            alert.addAction(
                UIAlertAction(
                    title: NSLocalizedString("Delete", comment: "Needs comment"),
                    style: .destructive,
                    handler: { action in
                        provider.flush()
                        self.setEditing(false, animated: true)
                }))

            alert.addAction(
                UIAlertAction(
                    title: NSLocalizedString("Cancel", comment: "Needs comment"),
                    style: .cancel,
                    handler: nil))
            
            alert.view.tintColor = UIColor(named: "tint")
            present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - UISearchControllerDelegate

extension SearchHistoryViewController: UISearchControllerDelegate {
    
    func didDismissSearchController(_ searchController: UISearchController) {
        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension SearchHistoryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if
            let query = searchBar.text,
            !query.isEmpty {
            
            if let provider = dataSourceController.provider as? CodableDataSourceProviding {
                let item = MovieSearchHistoryItem(query: query)
                provider.append(item: item)
            }
            dataSourceController.update()
            
            searchResultsController.query = query
        }
    }
}
