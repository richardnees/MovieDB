import Foundation

public protocol PagingDataSourceProviding: NetworkDataSourceProviding {
    var page: Int { get set }
    var totalPageCount: Int { get set }
    
    mutating func append(items: [DataSourceDisplayableItem])
    func loadNextPageIfNeeded()
}

extension PagingDataSourceProviding {
    public mutating func append(items: [DataSourceDisplayableItem]) {
        self.items += items
    }
}
