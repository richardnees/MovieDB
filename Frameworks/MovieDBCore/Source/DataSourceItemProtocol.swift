import Foundation

public protocol DataSourceItemProtocol: Codable {
    var cellIdentifier: String { get }
}

