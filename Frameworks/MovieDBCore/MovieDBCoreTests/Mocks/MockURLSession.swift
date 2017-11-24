import Foundation
import MovieDBCore

class MockURLSession: URLSessionProtocol {
    var mockDataTask = MockURLSessionDataTask()
    var error: Error?
    var data: Data?
    
    func apiDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
    
        if let data = data {
            completionHandler(data, nil, nil)
        } else if let error = self.error {
            completionHandler(nil, nil, error)
        } else {
            completionHandler(nil, nil, nil)
        }
        
        return mockDataTask
    }
}
