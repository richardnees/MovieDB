import Foundation

public typealias DataSourceProvidingErrorHandler = ((Error) -> Void)
public typealias DataSourceProvidingWillUpdateHandler = (() -> Void)
public typealias DataSourceProvidingDidUpdateHandler = (() -> Void)

/// Basic Data Source Providing Protocol
public protocol DataSourceProviding {
    
    /// Title shown in table view headers
    var headerTitle: String { get }
    
    /// Shown when data source is empty
    var emptyDataSourceInfoString: String { get }

    /// Shown when data source loading
    var loadingDataSourceInfoString: String { get }
    
    /// Data Source Items
    var items: [DataSourceItemProtocol] { get set }

    /// Data Source Items
    /// - important: This might differ from `items.count` when implementing e.g. paging
    var totalItemCount: Int { get }
    
    /// Called when errors occur
    var errorHandler: DataSourceProvidingErrorHandler? { get set }
    
    /// To be called when an update is done
    var didUpdate: DataSourceProvidingDidUpdateHandler? { get set }

    /// To be called when an update will begin
    var willUpdate: DataSourceProvidingWillUpdateHandler? { get set }
    
    /// Allow the table view's edit mode
    var allowsEditing: Bool { get }
    
    /// Allows flusing items
    var allowsFlush: Bool { get }

    func flush()
    func update()
}

extension DataSourceProviding {
    public var totalItemCount: Int {
        return items.count
    }

    public var allowsEditing: Bool {
        return false
    }

    public var allowsFlush: Bool {
        return false
    }
}
