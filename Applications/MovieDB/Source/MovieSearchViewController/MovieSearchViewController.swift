import UIKit
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

struct MovieSearchHistoryItem: DataSourceDisplayableItem {
    var query: String
    var modificationDate: Date

    init(query: String) {
        self.query = query
        modificationDate = Date()
    }
    
    var cellIdentifier: String {
        return String(describing: MovieSearchHistoryCell.self)
    }
}

class MovieSearchHistoryProvider: JSONCodableDataSourceProviding {    
    var headerTitle = NSLocalizedString("Recent Searches", comment: "Needs comment")
    var items: [DataSourceDisplayableItem] = []
    var totalItemCount: Int = 0
    var errorHandler: DataSourceProvidingErrorHandler?
    var updateHandler: DataSourceProvidingUpdateHandler?
    let allowsEditing = true
    
    var maxItemsCount = 10
    let storageURL = FileManager.applicationSupportURL.appendingPathComponent("MovieSearchHistory").appendingPathExtension("json")
    
    func load() {
        guard FileManager.default.fileExists(atPath: storageURL.path) else { return }

        do {
            let data = try Data(contentsOf: storageURL)
            let items = try decoder.decode([MovieSearchHistoryItem].self, from: data)
            self.items = items
        } catch let error {
            errorHandler?(error)
        }
        updateHandler?()
    }

    func update() {
        do {
            try FileManager.default.createDirectory(at: storageURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
            let historyItems = items as? [MovieSearchHistoryItem]
            let data = try encoder.encode(historyItems)
            try data.write(to: storageURL)
        } catch let error {
            errorHandler?(error)
        }
        updateHandler?()
    }
        
    func flush() {
        
        updateHandler?()
    }
    
    func append(item: DataSourceDisplayableItem) {
        items.insert(item, at: 0)
        
        if items.count >= maxItemsCount {
            items = Array(items[..<maxItemsCount])
        }
    }
}

class MovieSearchViewController: UITableViewController {

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

    lazy var searchResultsController: MovieSearchResultsViewController = {
        guard let searchResultsController = UIStoryboard(name: String(describing: MovieSearchResultsViewController.self), bundle: nil).instantiateInitialViewController() as? MovieSearchResultsViewController else {
            fatalError("We need a MovieSearchResultsViewController")
        }
        return searchResultsController
    }()
    
    lazy var searchController: UISearchController = {
        return UISearchController(searchResultsController: searchResultsController)
    }()
    
    // MARK: - View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = editButtonItem

        definesPresentationContext = true
        
        dataSourceController = DataSourceController()
        let provider = MovieSearchHistoryProvider()
        provider.load()
        dataSourceController.provider = provider
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let item = dataSourceController.provider.items[indexPath.row] as? MovieSearchHistoryItem else { return }
        
        searchController.searchBar.text = item.query
        present(searchController, animated: true) {
            self.searchResultsController.query = item.query
        }
    }
}

// MARK: - UISearchControllerDelegate

extension MovieSearchViewController: UISearchControllerDelegate {
    
    func didDismissSearchController(_ searchController: UISearchController) {
        // FIXME:
        //        searchResultsController.dataSource = nil
        
        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension MovieSearchViewController: UISearchBarDelegate {
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
