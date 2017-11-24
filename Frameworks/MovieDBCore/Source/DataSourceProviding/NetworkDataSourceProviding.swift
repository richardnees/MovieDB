import Foundation

/// Network Data Source Providing Protocol
public protocol NetworkDataSourceProviding: DataSourceProviding {
    
    /// Current URLSessionDataTaskProtocol in use
    var task: URLSessionDataTaskProtocol? { get set }
    
    /// Called to cancel current URLSessionDataTaskProtocol
    func cancel()
}

extension NetworkDataSourceProviding {
    public func cancel() {
        task?.cancel()
    }
}
