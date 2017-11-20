import Foundation

public struct MovieSearchContainer: Codable, ResourceContainer {
    public var page: Int
    public let totalResults: Int
    public let totalPages: Int
    public var results: [Movie]
    public var accumulatedResults: [Codable] = []
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}
