import Foundation

/// Protocol to ensure conformance.
public protocol APIClientProtocol {
    func load<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> Void)
    func dataTask<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> Void) -> URLSessionDataTaskProtocol
}

/// Used to request data tasks and perform networking.
public struct APIClient: APIClientProtocol {

    /// Shared instance of `APIClient`.
    static public let shared = APIClient(session: URLSession.shared)

    /// `URLSession` object that needs to conform to `URLSessionProtocol`.
    public let session: URLSessionProtocol
    
    /// Designated initializer of `APIClient`.
    public init(session: URLSessionProtocol) {
        self.session = session
    }
    
    /// Creates a `URLSessionDataTaskProtocol` instance from a generic `Resource` and resumes it immediately.
    ///
    /// - parameter resource:   Generic resource
    /// - parameter completion: The server's response to the request
    public func load<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> Void) {
        let task = dataTask(resource: resource, completion: completion)
        task.resume()
    }
    
    /// Creates a `URLSessionDataTaskProtocol` instance from a generic `Resource`.
    ///
    /// - parameter resource:   Generic resource
    /// - parameter completion: A `Result` with server's response to the request
    ///
    /// - returns: The new `URLSessionDataTaskProtocol` instance.
    public func dataTask<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> Void) -> URLSessionDataTaskProtocol {
        var request = URLRequest(url: resource.url)
        request.allHTTPHeaderFields = resource.allHTTPHeaderFields
        let task = session.apiDataTask(with: request) { data, response, error in
            
            if
                let response = response as? HTTPURLResponse,
                Array(400...500).contains(where: { $0 == response.statusCode }) {
                completion(Result.failure(APIClient.HTTPStatusError.httpError(code: response.statusCode)))
                return
            }

            if let error = error {
                completion(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(APIClient.ParsingError.noData))
                return
            }
            
            let parsedResult = resource.parse(data)
            switch parsedResult {
            case let .success(parsedResource):
                completion(Result.success(parsedResource))
            case let .failure(error):
                completion(Result.failure(error))
                break
            }
        }
        return task
    }
}
