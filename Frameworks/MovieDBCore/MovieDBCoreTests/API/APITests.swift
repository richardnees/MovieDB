import XCTest
@testable import MovieDBCore

class APITests: XCTestCase {

    func testDefaultQueryItems() {
        let defaultQueryItems = API.defaultQueryItems
        
        let expectedItems = [
            URLQueryItem(name: "api_key", value: "2696829a81b1b5827d515ff121700838")
        ]
        
        XCTAssertEqual(defaultQueryItems, expectedItems)
    }
    
    func testBaseURLComponents() {
        let urlComponents = API.baseURLComponents
        let expectedURL = URL(string: "https://api.themoviedb.org?api_key=2696829a81b1b5827d515ff121700838")
        
        XCTAssertEqual(urlComponents.url, expectedURL)
    }

}
