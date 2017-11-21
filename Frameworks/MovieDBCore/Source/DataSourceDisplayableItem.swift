import Foundation

public protocol DataSourceDisplayableItem: Codable {
    var cellIdentifier: String { get }
}

