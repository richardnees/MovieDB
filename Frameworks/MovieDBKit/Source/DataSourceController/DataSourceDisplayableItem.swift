import UIKit

public protocol DataSourceDisplayableItem {
    var cellIdentifier: String { get }
    var title: String { get }
    var releaseDate: Date? { get }
    var overview: String { get }
    var posterPathComponent: String? { get }
}
