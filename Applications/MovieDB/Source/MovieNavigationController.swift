import UIKit

class MovieNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // WORKAROUND:
        // We need to set this in code due to a bug with the storyboard in iOS 11
        // https://stackoverflow.com/questions/45144324/hide-large-title-when-scrolling-up
        navigationBar.prefersLargeTitles = true
    }
}
