import UIKit
import MovieDBCore

public class DataSourceController: NSObject {
        
    public var errorHandler: DataSourceProvidingErrorHandler?
    public var updateHandler: DataSourceProvidingUpdateHandler?

    public weak var tableView: UITableView? {
        didSet {
            guard let tableView = tableView else { return }
            
            tableView.register(DataSourceLoadingCell.nib, forCellReuseIdentifier: DataSourceLoadingCell.identifier)
            
            tableView.dataSource = self
            tableView.prefetchDataSource = self
            
            if let backgroundView = TableInfoBackgroundView.makeView(withOwner: self) {
                backgroundView.displayState = .empty
                tableView.backgroundView = backgroundView
            }
        }
    }
    
    public var infoView: TableInfoBackgroundView? {
        return tableView?.backgroundView as? TableInfoBackgroundView
    }
    
    public var provider: DataSourceProviding = DefaultDataSourceProvider() {
        didSet {
            provider.errorHandler = { error in
                DispatchQueue.main.async {
                    self.infoView?.errorInfoLabel.text = error.localizedDescription
                    self.infoView?.displayState = .error
                    self.infoView?.isHidden = false
                }
                self.errorHandler?(error)
            }
            
            provider.updateHandler = {
                DispatchQueue.main.async {
                    self.infoView?.emptyDataSourceInfoLabel.text = self.provider.emptyDataSourceInfoString
                    self.infoView?.displayState = .empty
                    self.infoView?.isHidden = self.provider.totalItemCount > 0
                }
                self.updateHandler?()
            }
        }
    }
    
    public func update() {
        provider.update()
    }
    
    public func cancel() {
        if let dataSource = provider as? DataSourceNetworkProviding {
            dataSource.cancel()
        }
    }
}
