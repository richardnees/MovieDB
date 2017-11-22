import UIKit
import MovieDBCore
import MovieDBKit

class MovieSearchResultsViewController: UITableViewController {

    var selectedMovieIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // WORKAROUND:
        // Remove the pesky separators in an empty table view
        // https://stackoverflow.com/questions/1633966/can-i-force-a-uitableview-to-hide-the-separator-between-empty-cells
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    var detailViewController: MovieDetailViewController? {
        return UIStoryboard(name: String(describing: MovieDetailViewController.self), bundle: nil).instantiateInitialViewController() as? MovieDetailViewController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let cell = sender as? MovieSearchResultCell,
            let movie = cell.item as? Movie,
            let movies = dataSourceController.provider.items as? [Movie],
            let index = movies.index(of: movie),
            let navigationController = segue.destination as? MovieNavigationController,
            let pageViewController = navigationController.topViewController as? MovieSearchResultsPageController,
            let detailViewController = detailViewController
            else {
                return
        }
        
        selectedMovieIndex = index
        
        pageViewController.delegate = self
        pageViewController.dataSource = self

        detailViewController.loadViewIfNeeded()
        detailViewController.item = movie
        pageViewController.setViewControllers([detailViewController], direction: .forward, animated: true, completion: nil)
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
                dataSourceController = DataSourceController()
                let provider = MovieSearchResultDataSourceProvider()
                provider.request = MovieSearchRequest(query: query)
                dataSourceController.provider = provider
                dataSourceController.update()
            }
        }
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Unwind Segues
    
    @IBAction func unwindModalPresentation(_ segue: UIStoryboardSegue) {
        let selectedIndexPath = IndexPath(row: selectedMovieIndex, section: 0)
        tableView.scrollToRow(at: selectedIndexPath, at: .middle, animated: true)
    }
}

extension MovieSearchResultsViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let previousIndex = selectedMovieIndex - 1
        
        guard
            previousIndex >= 0,
            let detailViewController = detailViewController,
            let movies = dataSourceController.provider.items as? [Movie]
            else {
                return nil
        }
        detailViewController.loadViewIfNeeded()
        detailViewController.item = movies[previousIndex]
        selectedMovieIndex = previousIndex
        return detailViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let nextIndex = selectedMovieIndex + 1
        
        guard
            nextIndex < dataSourceController.provider.totalItemCount,
            let detailViewController = detailViewController,
            let movies = dataSourceController.provider.items as? [Movie]
            else {
                return nil
        }
        detailViewController.loadViewIfNeeded()
        detailViewController.item = movies[nextIndex]
        selectedMovieIndex = nextIndex
        return detailViewController
    }
    
    
}

extension MovieSearchResultsViewController: UIPageViewControllerDelegate {
    
}
