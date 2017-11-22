import Foundation

public struct ResourceLoader {
    
    public enum ParsingError: Error {
        case noData
        case imageCreationFailed
    }
    
    public init() {
    }
    
    public func load<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> Void) {
        let task = dataTask(resource: resource, completion: completion)
        task.resume()
    }
    
    public func dataTask<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: resource.url)
        request.allHTTPHeaderFields = resource.allHTTPHeaderFields
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(ResourceLoader.ParsingError.noData))
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

