import XCTest
@testable import MovieDBCore

class MovieSearchContainerTests: XCTestCase {
    
    var apiClient: APIClient!
    let session = MockURLSession()
    let timeout: TimeInterval = 0
    let dataURL = Bundle(for: MovieSearchContainerTests.self).url(forResource: "MovieSearchContainer", withExtension: "json")
    let request = MovieSearchRequest(query: "test")
    
    override func setUp() {
        super.setUp()
        apiClient = APIClient(session: session)
    }

    func testInitSuccess() {
        let resource = MovieSearchContainer.resource(with: request)
        let expect = expectation(description: "Wait for \(request.url) to load.")
        var expectedContainer: MovieSearchContainer?
        
        
        guard
            let dataURL = dataURL,
            let data = try? Data(contentsOf: dataURL)
            else {
                XCTAssert(false)
                return
        }
        
        session.data = data
        apiClient.load(resource: resource) { result in
            switch result {
            case let .success(container):
                expectedContainer = container
                expect.fulfill()
            case .failure(_):
                XCTAssert(false)
            }
            
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNotNil(expectedContainer)
    }

    func testInitFail() {
        let resource = MovieSearchContainer.resource(with: request)
        
        let expect = expectation(description: "Wait for \(request.url) to fail.")
        var expectedContainer: MovieSearchContainer?
        
        session.data = "{}".data(using: .utf8)
        apiClient.load(resource: resource) { result in
            switch result {
            case let .success(container):
                expectedContainer = container
                XCTAssert(false)
            case let .failure(error):
                print(error)
                expect.fulfill()
            }
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(expectedContainer)
    }
    
}
