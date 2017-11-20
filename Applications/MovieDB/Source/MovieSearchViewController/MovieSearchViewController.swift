import UIKit

class MovieSearchViewController: UITableViewController {

    var dataSource: [String] = []
    
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
        
        // We need to set this in code due to a bug with the storyboard in iOS 11
        // https://stackoverflow.com/questions/45144324/hide-large-title-when-scrolling-up
        navigationController?.navigationBar.prefersLargeTitles = true

        searchController.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = editButtonItem

        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSearchHistoryCell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query = dataSource[indexPath.row]
        searchController.searchBar.text = query
        present(searchController, animated: true) {
            self.searchResultsController.query = query
        }
    }
}

// MARK: - UISearchControllerDelegate

extension MovieSearchViewController: UISearchControllerDelegate {
    
    func didDismissSearchController(_ searchController: UISearchController) {
        searchResultsController.dataSource = nil
    }
}

// MARK: - UISearchBarDelegate

extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if
            let query = searchBar.text,
            !query.isEmpty {
            
            dataSource.insert(query, at: 0)
            tableView.reloadData()
            
            searchResultsController.query = query
        }
    }
}

