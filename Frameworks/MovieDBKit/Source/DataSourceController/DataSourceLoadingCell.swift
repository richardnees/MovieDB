import UIKit

public class DataSourceLoadingCell: UITableViewCell {

    static let identifier = String(describing: DataSourceLoadingCell.self)
    static let nibName = String(describing: DataSourceLoadingCell.self)

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
