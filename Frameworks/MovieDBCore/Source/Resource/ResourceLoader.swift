import Foundation

public struct ResourceLoader {

    public enum LoardingError: Error {
        case badParsing
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
            
            guard
                let data = data,
                let success = try? resource.parse(data) else {
                    completion(Result.failure(ResourceLoader.LoardingError.badParsing))
                    return
                }
                
            completion(Result.success(success))
        }
        return task
    }
}
