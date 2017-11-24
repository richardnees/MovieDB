import Foundation

/// Protocol to ensure that items have associated cell identifiers
public protocol DataSourceItemProtocol: Codable {
    var cellIdentifier: String { get }
}
