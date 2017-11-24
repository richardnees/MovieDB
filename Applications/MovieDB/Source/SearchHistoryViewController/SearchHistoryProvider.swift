import Foundation
import MovieDBCore
import MovieDBKit

class SearchHistoryProvider: JSONCodableDataSourceProviding {
    var headerTitle = NSLocalizedString("Recent Searches", comment: "Needs comment")
    var emptyDataSourceInfoString = NSLocalizedString("No recent searches", comment: "Needs comment")
    var loadingDataSourceInfoString = NSLocalizedString("Loading…", comment: "Needs comment")
    var items: [DataSourceItemProtocol] = []
    var errorHandler: DataSourceProvidingErrorHandler?
    var updateHandler: DataSourceProvidingUpdateHandler?
    var prepareHandler: DataSourceProvidingPreparationHandler?
    let allowsEditing = true
    let allowsFlush = true

    var maxItemsCount = 10
    let storageURL = FileManager.default.applicationSupportURL.appendingPathComponent("MovieSearchHistory").appendingPathExtension("json")
    
    func load() {
        prepareHandler?()

        guard FileManager.default.fileExists(atPath: storageURL.path) else {
            updateHandler?()
            return
        }
        
        do {
            let data = try Data(contentsOf: storageURL)
            let items = try decoder.decode([MovieSearchHistoryItem].self, from: data)
            self.items = items
        } catch let error {
            errorHandler?(error)
        }
        updateHandler?()
    }
    
    func update() {
        do {
            try FileManager.default.createDirectory(at: storageURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
            let historyItems = items as? [MovieSearchHistoryItem]
            let data = try encoder.encode(historyItems)
            try data.write(to: storageURL)
        } catch let error {
            errorHandler?(error)
        }
        updateHandler?()
    }
    
    func flush() {
        if allowsFlush {
            items = []
        }
        update()
        updateHandler?()
    }
    
    func append(item: DataSourceItemProtocol) {
        items.insert(item, at: 0)
        
        if items.count >= maxItemsCount {
            items = Array(items[..<maxItemsCount])
        }
    }
}