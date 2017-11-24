import Foundation
import MovieDBCore

public class DefaultDataSourceProvider: DataSourceProviding {
    public var headerTitle = ""
    public var emptyDataSourceInfoString = ""
    public var loadingDataSourceInfoString = ""
    public var items: [DataSourceItemProtocol] = []
    public var totalItemCount: Int = 0
    public var errorHandler: DataSourceProvidingErrorHandler?
    public var updateHandler: DataSourceProvidingUpdateHandler?
    public var prepareHandler: DataSourceProvidingPreparationHandler?
    public func update() {
        updateHandler?()
    }
}
