import UIKit
import MovieDBCore

extension SearchResultsViewController {
    
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
    
    var makeDetailViewController: DetailViewController? {
        return UIStoryboard(name: String(describing: DetailViewController.self), bundle: nil).instantiateInitialViewController() as? DetailViewController
    }
    
    @IBAction func unwindModalPresentation(_ segue: UIStoryboardSegue) {
        
        presentModalDetails(false)
        let selectedIndexPath = IndexPath(row: selectedMovieIndex, section: 0)
        tableView.scrollToRow(at: selectedIndexPath, at: .top, animated: false)
    }
    
    // MARK: - Animations
    
    func presentModalDetails(_ presenting: Bool) {
        
        let animation = UIViewPropertyAnimator(duration: 0.25, curve: presenting ? .easeIn : .easeOut, animations: { [weak self] in
            guard let animatedViewController = self?.animatedViewController else { return }
            
            animatedViewController.view.layer.opacity = presenting ? 0.2 : 1.0
            animatedViewController.view.layer.transform = presenting ? SearchResultsViewController.animatedTransform : CATransform3DIdentity
        })
        
        animation.startAnimation()
    }
    
    static var animatedTransform: CATransform3D = {
        
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -500
        
        return CATransform3DRotate(transform, CGFloat(Double.pi)/4, 1.0, 0.0, 0.0)
    }()
    
}
