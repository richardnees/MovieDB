import UIKit

public class TableInfoBackgroundView: UIView {

    static let nibName = String(describing: TableInfoBackgroundView.self)
    
    public static func makeView(withOwner owner: Any) -> TableInfoBackgroundView? {
        return Bundle(for: TableInfoBackgroundView.self).loadNibNamed(nibName, owner: owner, options: nil)?.first as? TableInfoBackgroundView
    }

    public enum DisplayState {
        case empty
        case error
    }
    
    public var displayState: DisplayState = .empty {
        didSet {
            switch displayState {
            case .empty:
                emptyDataSourceInfoLabel.isHidden = false
                errorInfoLabel.isHidden = true
            case .error:
                emptyDataSourceInfoLabel.isHidden = true
                errorInfoLabel.isHidden = false
            }
        }
    }
    
    @IBOutlet weak var emptyDataSourceInfoLabel: UILabel!
    @IBOutlet weak var errorInfoLabel: UILabel!
}
