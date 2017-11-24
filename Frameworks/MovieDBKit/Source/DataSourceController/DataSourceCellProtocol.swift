import Foundation
import MovieDBCore

public protocol DataSourceCellProtocol {
    var item: DataSourceItemProtocol? { get set }
}
