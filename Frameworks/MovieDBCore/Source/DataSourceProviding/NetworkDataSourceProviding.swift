import Foundation

public protocol NetworkDataSourceProviding: DataSourceProviding {
    var task: URLSessionDataTask? { get set }
    func cancel()
}

extension NetworkDataSourceProviding {
    public func cancel() {
        task?.cancel()
    }
}
