import UIKit

/// Used to provide information in Table View
public class TableInfoBackgroundView: UIView {

    /// Nib name of `TableInfoBackgroundView`
    static let nibName = String(describing: TableInfoBackgroundView.self)

    /// Make and load a new `TableInfoBackgroundView` from Nib
    public static func makeView(withOwner owner: Any) -> TableInfoBackgroundView? {
        return Bundle(for: TableInfoBackgroundView.self).loadNibNamed(nibName, owner: owner, options: nil)?.first as? TableInfoBackgroundView
    }
    
    /// Multi-line info label
    @IBOutlet weak var infoLabel: UILabel!
}
