import Foundation

public typealias DataSourceProvidingUpdateHandler = (() -> Void)
public typealias DataSourceProvidingErrorHandler = ((Error) -> Void)

public protocol DataSourceProviding {
    var headerTitle: String { get }
    var items: [DataSourceDisplayableItem] { get set }
    var totalItemCount: Int { get }
    var errorHandler: DataSourceProvidingErrorHandler? { get set }
    var updateHandler: DataSourceProvidingUpdateHandler? { get set }
    var allowsEditing: Bool { get }

    func update()
}

extension DataSourceProviding {
    public var totalItemCount: Int {
        return items.count
    }

    public var allowsEditing: Bool {
        return false
    }
}
