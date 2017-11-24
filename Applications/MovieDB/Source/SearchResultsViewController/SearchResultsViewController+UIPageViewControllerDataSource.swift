import UIKit
import MovieDBCore

extension SearchResultsViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard
            let movies = dataSourceController.provider.items as? [Movie],
            let currentController = viewController as? DetailViewController,
            let currentMovie = currentController.item as? Movie,
            let currentIndex = movies.index(of: currentMovie),
            let detailViewController = makeDetailViewController,
            currentIndex > 0
            else {
                return nil
        }

        let previousIndex = currentIndex - 1
        detailViewController.loadViewIfNeeded()
        detailViewController.item = movies[previousIndex]
        
        return detailViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard
            let movies = dataSourceController.provider.items as? [Movie],
            let currentController = viewController as? DetailViewController,
            let currentMovie = currentController.item as? Movie,
            let currentIndex = movies.index(of: currentMovie),
            let detailViewController = makeDetailViewController,
            currentIndex < dataSourceController.provider.totalItemCount - 1
            else {
                return nil
        }

        let nextIndex = currentIndex + 1
        detailViewController.loadViewIfNeeded()
        detailViewController.item = movies[nextIndex]
        
        return detailViewController
    }
    
}

extension SearchResultsViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard
            let movies = dataSourceController.provider.items as? [Movie],
            let currentController = pageViewController.viewControllers?.first as? DetailViewController,
            let currentMovie = currentController.item as? Movie,
            let currentIndex = movies.index(of: currentMovie)
            else {
                return
        }

        selectedMovieIndex = currentIndex
    }
    
}
