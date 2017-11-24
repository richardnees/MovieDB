import UIKit

public class TableInfoBackgroundView: UIView {

    static let nibName = String(describing: TableInfoBackgroundView.self)
    
    public static func makeView(withOwner owner: Any) -> TableInfoBackgroundView? {
        return Bundle(for: TableInfoBackgroundView.self).loadNibNamed(nibName, owner: owner, options: nil)?.first as? TableInfoBackgroundView
    }
    
    @IBOutlet weak var infoLabel: UILabel!
}
