import Foundation

public protocol DataSourceNetworkPagingProviding: DataSourceNetworkProviding {
    var page: Int { get set }
    var totalPageCount: Int { get set }
    
    mutating func append(items: [DataSourceDisplayableItem])
    func loadNextPageIfNeeded()
}

extension DataSourceNetworkPagingProviding {
    public mutating func append(items: [DataSourceDisplayableItem]) {
        self.items += items
    }
}
