import Foundation

public protocol PagingNetworkDataSourceProviding: NetworkDataSourceProviding {
    var page: Int { get set }
    var totalPageCount: Int { get set }
    
    mutating func append(items: [DataSourceItemProtocol])
    func loadNextPageIfNeeded()
}

extension PagingNetworkDataSourceProviding {
    public mutating func append(items: [DataSourceItemProtocol]) {
        self.items += items
    }
}
