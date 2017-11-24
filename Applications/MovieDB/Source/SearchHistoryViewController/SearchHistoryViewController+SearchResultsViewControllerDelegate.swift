import UIKit
import MovieDBCore

extension SearchHistoryViewController: SearchResultsViewControllerDelegate {

    func searchResultsViewController(_ searchResultsViewController: SearchResultsViewController, successfullySearchedFor query: String) {
        if let provider = dataSourceController.provider as? LocalCodableDataSourceProviding {
            let item = MovieSearchHistoryItem(query: query)
            provider.append(item: item)
        }
    
        dataSourceController.update()
    }
    
    func searchResultsViewController(_ searchResultsViewController: SearchResultsViewController, unsuccessfullySearchedFor query: String) {
        let alert = UIAlertController(
            title: NSLocalizedString("No results", comment: "Needs comment"),
            message: NSLocalizedString("No results for \"\(query)\"", comment: "Needs comment"),
            preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("OK", comment: "Needs comment"),
                style: .default,
                handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
