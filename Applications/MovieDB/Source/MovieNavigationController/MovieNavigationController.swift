import UIKit

class MovieNavigationController: UINavigationController {

    override func awakeFromNib() {
        super.awakeFromNib()

        // WORKAROUND:
        // Again an IB issue, where setting this in the storyboard causes an exception
        navigationBar.largeTitleTextAttributes = navigationBar.titleTextAttributes
    }
}
