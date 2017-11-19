import Foundation

public struct ResourceLoader {
    
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
                completion(Result.error(error))
                return
            }

            guard
                let data = data,
                let success = resource.parse(data) else {
                    return
                }
                
            completion(Result.success(success))
        }
        return task
    }
}
