import Foundation
import MovieDBCore
import MovieDBKit

class SearchHistoryProvider: JSONCodableDataSourceProviding {
    
    var headerTitle = NSLocalizedString("Recent Searches", comment: "Needs comment")
    var emptyDataSourceInfoString = NSLocalizedString("No recent searches", comment: "Needs comment")
    var loadingDataSourceInfoString = NSLocalizedString("Loading…", comment: "Needs comment")
    
    var items: [DataSourceItemProtocol] = []
    
    var errorHandler: DataSourceProvidingErrorHandler?
    var didUpdate: DataSourceProvidingDidUpdateHandler?
    var willUpdate: DataSourceProvidingWillUpdateHandler?
    
    let allowsEditing = true
    let allowsFlush = true
    
    var currentVersion = 1
    var maxItemsCount = 10
    let storageURL = FileManager.default.applicationSupportURL.appendingPathComponent("MovieSearchHistory").appendingPathExtension("json")
    
    func load() {
        willUpdate?()
        
        guard FileManager.default.fileExists(atPath: storageURL.path) else {
            didUpdate?()
            return
        }
        
        do {
            let data = try Data(contentsOf: storageURL)
            let container = try decoder.decode(MovieSearchHistoryContainer.self, from: data)
            if
                let items = container.items,
                container.version >= currentVersion {
                self.items = items
            }
        } catch let error {
            errorHandler?(error)
        }
        didUpdate?()
    }
    
    func update() {
        do {
            try FileManager.default.createDirectory(at: storageURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
            let historyItems = items as? [MovieSearchHistoryItem]
            let container = MovieSearchHistoryContainer(version: currentVersion, items: historyItems)
            let data = try encoder.encode(container)
            try data.write(to: storageURL)
        } catch let error {
            errorHandler?(error)
        }
        didUpdate?()
    }
    
    func flush() {
        if allowsFlush {
            items = []
        }
        update()
        didUpdate?()
    }
    
    func append(item: DataSourceItemProtocol) {
        if
            let historyItem = item as? MovieSearchHistoryItem,
            let historyItems = items as? [MovieSearchHistoryItem],
            let index = historyItems.index(of: historyItem) {
            items.remove(at: index)
        }
        
        items.insert(item, at: 0)
        
        if items.count >= maxItemsCount {
            items = Array(items[..<maxItemsCount])
        }
    }
}
