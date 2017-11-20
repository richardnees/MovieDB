import Foundation

public protocol ResourceContainer {
    var page: Int { get set }
    var totalResults: Int { get }
    var totalPages: Int { get }
    var accumulatedResults: [Codable]  { get set }
}
