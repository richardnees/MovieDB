import XCTest
@testable import MovieDBCore

class MovieSearchRequestTests: XCTestCase {
    func testURLFromRequest() {
        let request = MovieSearchRequest(query: "test", page: 9)
        let requestURL = request.url
        
        let expectedURL = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&page=9&query=test")
        
        XCTAssertEqual(requestURL, expectedURL)
    }
}
