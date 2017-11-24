import Foundation

public struct MovieSearchHistoryContainer: Codable {
    public let version: Int
    public var items: [MovieSearchHistoryItem]?
    
    public init(version: Int, items: [MovieSearchHistoryItem]?) {
        self.version = version
        self.items = items
    }
}
