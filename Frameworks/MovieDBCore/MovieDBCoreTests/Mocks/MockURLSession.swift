import Foundation
import MovieDBCore

class MockURLSession: URLSessionProtocol {

    var mockDataTask = MockURLSessionDataTask()
    var error: Error?
    var response: URLResponse?
    var data: Data?
    
    func apiDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        completionHandler(data, response, error)
        return mockDataTask
    }

}
