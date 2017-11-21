import Foundation

public struct MovieSearchContainer: Codable {
    public var page: Int
    public let totalResultCount: Int
    public let totalPageCount: Int
    public var results: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResultCount = "total_results"
        case totalPageCount = "total_pages"
        case results = "results"
    }
}
