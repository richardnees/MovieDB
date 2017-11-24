import UIKit
import MovieDBCore

public protocol DataSourceControllerProtocol {
    
    var provider: DataSourceProviding { get set }
    
    /// Called when errors occur
    var errorHandler: DataSourceProvidingErrorHandler? { get set }
    
    /// To be called when an update is done
    var didUpdate: DataSourceProvidingDidUpdateHandler? { get set }
    
    /// To be called when an update will begin
    var willUpdate: DataSourceProvidingWillUpdateHandler? { get set }
    
    func update()
    func cancel()
}

public class DataSourceController: NSObject, DataSourceControllerProtocol {
    
    // MARK: - Handlers

    public var errorHandler: DataSourceProvidingErrorHandler?
    public var willUpdate: DataSourceProvidingWillUpdateHandler?
    public var didUpdate: DataSourceProvidingDidUpdateHandler?

    // MARK: - Views

    /// Provide a table view. Required when using a paging data source provider
    public weak var tableView: UITableView? {
        didSet {
            guard let tableView = tableView else { return }
            
            tableView.register(DataSourceLoadingCell.nib, forCellReuseIdentifier: DataSourceLoadingCell.identifier)
            
            tableView.dataSource = self
            tableView.prefetchDataSource = self
            
            if let backgroundView = TableInfoBackgroundView.makeView(withOwner: self) {
                tableView.backgroundView = backgroundView
            }
            
            tableView.reloadData()
        }
    }
    
    public var infoView: TableInfoBackgroundView? {
        return tableView?.backgroundView as? TableInfoBackgroundView
    }
    
    // MARK: - Provider

    public var provider: DataSourceProviding = DefaultDataSourceProvider() {
        didSet {
            provider.errorHandler = { error in
                DispatchQueue.main.async {
                    self.errorHandler?(error)
                }
            }
            
            provider.willUpdate = {
                DispatchQueue.main.async {
                    self.infoView?.infoLabel.text = self.provider.loadingDataSourceInfoString
                    self.infoView?.isHidden =  false
                    self.willUpdate?()
                }
            }
            
            provider.didUpdate = {
                DispatchQueue.main.async {
                    self.infoView?.isHidden = self.provider.totalItemCount > 0 ? true : false
                    self.infoView?.infoLabel.text = self.provider.totalItemCount > 0
                        ? ""
                        : self.provider.emptyDataSourceInfoString
                    self.didUpdate?()
                }
            }
        }
    }
    
    // MARK: - Actions

    public func update() {
        provider.update()
    }
    
    public func cancel() {
        if let dataSource = provider as? NetworkDataSourceProviding {
            dataSource.cancel()
        }
    }
}
