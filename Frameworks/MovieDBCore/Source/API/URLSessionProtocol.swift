import Foundation

public typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

/// Protocol to ensure conformance.
public protocol URLSessionProtocol {
    func apiDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    /// Creates a `URLSessionDataTaskProtocol` instance from a `URLRequest`.
    ///
    /// - parameter request:    URL request.
    /// - parameter completion: The server's response to the request.
    ///
    /// - returns: The new `URLSessionDataTaskProtocol` instance.
    public func apiDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        let task = dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }
        return task
    }
}

/// Protocol to ensure conformance.
public protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
    
}
