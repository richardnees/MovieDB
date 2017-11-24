import UIKit

extension SearchHistoryViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if
            let query = searchBar.text,
            !query.isEmpty {
            searchResultsController.query = query
        }
    }

}
