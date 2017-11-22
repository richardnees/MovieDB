import UIKit

public class DataSourceLoadingCell: UITableViewCell {

    static let identifier = String(describing: DataSourceLoadingCell.self)
    static let nibName = String(describing: DataSourceLoadingCell.self)

    public static var nib: UINib = {
        return UINib(nibName: DataSourceLoadingCell.nibName, bundle: Bundle(for: DataSourceLoadingCell.self))
    }()

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}
