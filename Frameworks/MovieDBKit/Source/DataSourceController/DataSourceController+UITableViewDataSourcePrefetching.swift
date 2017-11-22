import Foundation
import MovieDBCore

extension DataSourceController: UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let dataSourceProvider = provider as? DataSourceNetworkPagingProviding {
            dataSourceProvider.loadNextPageIfNeeded()
        }
    }
}
