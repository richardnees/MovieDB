import XCTest
@testable import MovieDBCore

class APIClientTests: XCTestCase {
    var subject: APIClient!
    let session = MockURLSession()
    let timeout: TimeInterval = 0
    
    override func setUp() {
        super.setUp()
        subject = APIClient(session: session)
    }

    func testLoad() {
        let url = URL(string: "https://www.apple.com")!
        let expect = expectation(description: "Wait for \(url) to load.")
        var expectedData: Data?
        
        let resource = Resource<Data>(url: url) { data -> Result<Data> in
            return Result.success(data)
        }
        
        session.data = "[]".data(using: .utf8)
        subject.load(resource: resource) { result in
            switch result {
            case let .success(data):
                expectedData = data
                expect.fulfill()
            case .failure(_):
                XCTAssert(false)
            }
            
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNotNil(expectedData)
    }

    func testLoadParseError() {
        let url = URL(string: "https://www.apple.com")!
        let expect = expectation(description: "Wait for \(url) parse to fail.")
        var expectedError: Error?
        
        let resource = Resource<Data>(url: url) { data -> Result<Data> in
            let error = NSError(domain: "Parse Error", code: 1000, userInfo: nil)
            return Result.failure(error)
        }
        
        session.data = "[]".data(using: .utf8)
        subject.load(resource: resource) { result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case let .failure(error):
                expectedError = error
                expect.fulfill()
            }
            
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNotNil(expectedError)
    }

    func testLoadTaskError() {
        let url = URL(string: "https://www.apple.com")!
        let expect = expectation(description: "Wait for \(url) data dask to fail.")
        var expectedError: Error?
        
        let resource = Resource<Data>(url: url) { data -> Result<Data> in
            return Result.success(data)
        }
        
        session.error = NSError(domain: "Task Error", code: 2000, userInfo: nil)
        subject.load(resource: resource) { result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case let .failure(error):
                expectedError = error
                expect.fulfill()
            }
            
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(expectedError)
    }

    func testLoadNoDataError() {
        let url = URL(string: "https://www.apple.com")!
        let expect = expectation(description: "Wait for \(url) to fail with no data.")
        var expectedError: Error?
        
        let resource = Resource<Data>(url: url) { data -> Result<Data> in
            return Result.success(data)
        }
        
        subject.load(resource: resource) { result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case let .failure(error):
                expectedError = error
                expect.fulfill()
            }
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNotNil(expectedError)
    }

    func testLoadHTTPResponseError() {
        let url = URL(string: "https://www.apple.com")!
        let expect = expectation(description: "Wait for \(url) to fail with no data.")
        var expectedError: Error?
        
        let resource = Resource<Data>(url: url) { data -> Result<Data> in
            return Result.success(data)
        }
        session.response = HTTPURLResponse(url: url, statusCode: 403, httpVersion: nil, headerFields: nil)
        subject.load(resource: resource) { result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case let .failure(error):
                expectedError = error
                expect.fulfill()
            }
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNotNil(expectedError)
    }
}
