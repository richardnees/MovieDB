import Foundation

public protocol DataSourceNetworkProviding: DataSourceProviding {
    var task: URLSessionDataTask? { get set }
    func cancel()
}

extension DataSourceNetworkProviding {
    public func cancel() {
        task?.cancel()
    }
}
