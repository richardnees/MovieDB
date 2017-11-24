import XCTest
@testable import MovieDBCore

class MovieDBCoreTests: XCTestCase {

    func testBundle() {
        let bundle = MovieDBCore.bundle
        
        XCTAssert(bundle.bundleIdentifier == "com.richardnees.framework.MovieDBCore")
    }

}
