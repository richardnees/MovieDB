import UIKit
import MovieDBCore

public class DataSourceController: NSObject {
        
    public var errorHandler: DataSourceProvidingErrorHandler?
    public var updateHandler: DataSourceProvidingUpdateHandler?

    public weak var tableView: UITableView? {
        didSet {
            guard let tableView = tableView else { return }
            
            let nib = UINib(nibName: DataSourceLoadingCell.nibName, bundle: Bundle(for: DataSourceLoadingCell.self))
            tableView.register(nib, forCellReuseIdentifier: DataSourceLoadingCell.identifier)
            
            tableView.dataSource = self
            tableView.prefetchDataSource = self

        }
    }
    
    public var provider: DataSourceProviding = DefaultDataSourceProvider() {
        didSet {
            provider.errorHandler = { error in
                self.errorHandler?(error)
            }
            
            provider.updateHandler = {
                self.updateHandler?()
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
