import UIKit
import MovieDBCore

public class DataSourceController: NSObject {
        
    public var errorHandler: DataSourceProvidingErrorHandler?
    public var prepareHandler: DataSourceProvidingPreparationHandler?
    public var updateHandler: DataSourceProvidingUpdateHandler?

    public weak var tableView: UITableView? {
        didSet {
            guard let tableView = tableView else { return }
            
            tableView.register(DataSourceLoadingCell.nib, forCellReuseIdentifier: DataSourceLoadingCell.identifier)
            
            tableView.dataSource = self
            tableView.prefetchDataSource = self
            
            if let backgroundView = TableInfoBackgroundView.makeView(withOwner: self) {
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
                    self.errorHandler?(error)
                }
            }
            
            provider.prepareHandler = {
                DispatchQueue.main.async {
                    if let backgroundView = self.tableView?.backgroundView as? TableInfoBackgroundView {
                        backgroundView.infoLabel.text = self.provider.loadingDataSourceInfoString
                    }
                self.prepareHandler?()
                }
            }
            
            provider.updateHandler = {
                DispatchQueue.main.async {
                    self.tableView?.backgroundView?.isHidden = self.provider.totalItemCount > 0
                    if let backgroundView = self.tableView?.backgroundView as? TableInfoBackgroundView {
                        backgroundView.infoLabel.text = self.provider.totalItemCount > 0
                        ? ""
                        : self.provider.emptyDataSourceInfoString
                    }
                self.updateHandler?()
                }
            }
        }
    }
    
    public func update() {
        provider.update()
    }
    
    public func cancel() {
        if let dataSource = provider as? NetworkDataSourceProviding {
            dataSource.cancel()
        }
    }
}
