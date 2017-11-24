import UIKit
import MovieDBCore
import MovieDBKit

class SearchResultsViewController: UITableViewController {

    var selectedMovieIndex: Int = 0
    var animatedViewController: UIViewController? {
        didSet {
            guard let animatedViewController = animatedViewController else { return }
            animatedViewController.view.layer.zPosition = -1000
        }
    }
    
    var animatedTransform: CATransform3D = {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -500
        return CATransform3DRotate(transform, CGFloat(Double.pi)/4, 1.0, 0.0, 0.0)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // WORKAROUND:
        // Remove the pesky separators in an empty table view
        // https://stackoverflow.com/questions/1633966/can-i-force-a-uitableview-to-hide-the-separator-between-empty-cells
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    var makeDetailViewController: DetailViewController? {
        return UIStoryboard(name: String(describing: DetailViewController.self), bundle: nil).instantiateInitialViewController() as? DetailViewController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let cell = sender as? SearchResultCell,
            let movie = cell.item as? Movie,
            let movies = dataSourceController.provider.items as? [Movie],
            let index = movies.index(of: movie),
            let navigationController = segue.destination as? UINavigationController,
            let pageViewController = navigationController.topViewController as? SearchResultsPageController,
            let detailViewController = makeDetailViewController
            else {
                return
        }
        
        selectedMovieIndex = index
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        detailViewController.loadViewIfNeeded()
        detailViewController.item = movie
        
        animatedViewController = presentingViewController?.navigationController
        presentModalDetails(true)
        
        pageViewController.setViewControllers([detailViewController], direction: .forward, animated: true, completion: nil)
    }
    
    var dataSourceController = DataSourceController() {
        didSet {
            
            tableView.reloadData()
            
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
            
            dataSourceController.updateHandler = {
                self.tableView.reloadData()
            }
        }
    }
        
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
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Unwind Segues
    
    @IBAction func unwindModalPresentation(_ segue: UIStoryboardSegue) {
        presentModalDetails(false)
        let selectedIndexPath = IndexPath(row: selectedMovieIndex, section: 0)
        tableView.scrollToRow(at: selectedIndexPath, at: .top, animated: false)
    }
    
    func presentModalDetails(_ presenting: Bool) {
        let animation = UIViewPropertyAnimator(duration: 0.25, curve: presenting ? .easeIn : .easeOut, animations: { [weak self] in
            guard
                let animatedTransform = self?.animatedTransform,
                let animatedViewController = self?.animatedViewController
                else {
                    return
            }
            
            animatedViewController.view.layer.opacity = presenting ? 0.2 : 1.0
            animatedViewController.view.layer.transform = presenting ? animatedTransform : CATransform3DIdentity
        })
        
        animation.startAnimation()
    }
}
