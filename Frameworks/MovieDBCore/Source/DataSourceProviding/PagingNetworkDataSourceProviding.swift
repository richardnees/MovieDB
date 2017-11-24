import Foundation

/// Paging Network Data Source Providing Protocol
public protocol PagingNetworkDataSourceProviding: NetworkDataSourceProviding {
    
    /// Current page
    var page: Int { get set }
    
    /// Total Pages available
    var totalPageCount: Int { get set }

    /// Called to accumulate items
    mutating func append(items: [DataSourceItemProtocol])

    /// Called to load next page
    func loadNextPageIfNeeded()
}

extension PagingNetworkDataSourceProviding {
    public mutating func append(items: [DataSourceItemProtocol]) {
        self.items += items
    }
}
