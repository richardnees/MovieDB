import XCTest
@testable import MovieDBKit

class DataSourceControllerTests: XCTestCase {
    
    let timeout = 0.05
    var dataSourceController: DataSourceController!
    
    override func setUp() {
        super.setUp()
        dataSourceController = DataSourceController()
    }
    
    func testUpdate() {
        
        let provider = DefaultDataSourceProvider()
        dataSourceController.provider = provider
        
        let expect = expectation(description: "Wait for update.")
        var success = false
        
        dataSourceController.didUpdate = {
            success = true
            expect.fulfill()
        }
        
        dataSourceController.update()
        
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssert(success)
        
    }
}
