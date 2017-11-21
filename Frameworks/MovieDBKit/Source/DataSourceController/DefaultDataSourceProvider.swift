import Foundation
import MovieDBCore

public class DefaultDataSourceProvider: DataSourceProviding {
    public var headerTitle = ""
    public var items: [DataSourceDisplayableItem] = []
    public var totalItemCount: Int = 0
    public var errorHandler: DataSourceProvidingErrorHandler?
    public var updateHandler: DataSourceProvidingUpdateHandler?
    public func update() {
    }
}
