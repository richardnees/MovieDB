import Foundation

public typealias DataSourceProvidingErrorHandler = ((Error) -> Void)
public typealias DataSourceProvidingPreparationHandler = (() -> Void)
public typealias DataSourceProvidingUpdateHandler = (() -> Void)

public protocol DataSourceProviding {
    var headerTitle: String { get }
    var emptyDataSourceInfoString: String { get }
    var loadingDataSourceInfoString: String { get }
    var items: [DataSourceItemProtocol] { get set }
    var totalItemCount: Int { get }
    var errorHandler: DataSourceProvidingErrorHandler? { get set }
    var updateHandler: DataSourceProvidingUpdateHandler? { get set }
    var prepareHandler: DataSourceProvidingPreparationHandler? { get set }
    var allowsEditing: Bool { get }
    var allowsFlush: Bool { get }

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
