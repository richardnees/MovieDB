import Foundation

public protocol NetworkDataSourceProviding: DataSourceProviding {
    var task: URLSessionDataTaskProtocol? { get set }
    func cancel()
}

extension NetworkDataSourceProviding {
    public func cancel() {
        task?.cancel()
    }
}
