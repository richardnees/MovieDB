import Foundation

public protocol APIClientProtocol {
    func load<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> Void)
    func dataTask<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> Void) -> URLSessionDataTaskProtocol
}

public struct APIClient: APIClientProtocol {

    static public let shared = APIClient(session: URLSession.shared)
    
    public let session: URLSessionProtocol
    
    public init(session: URLSessionProtocol) {
        self.session = session
    }
    
    public func load<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> Void) {
        let task = dataTask(resource: resource, completion: completion)
        task.resume()
    }
    
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
