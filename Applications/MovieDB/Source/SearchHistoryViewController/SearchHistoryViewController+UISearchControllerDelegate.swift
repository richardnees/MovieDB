import UIKit

extension SearchHistoryViewController: UISearchControllerDelegate {
    
    func didDismissSearchController(_ searchController: UISearchController) {
        tableView.reloadData()
    }

}
