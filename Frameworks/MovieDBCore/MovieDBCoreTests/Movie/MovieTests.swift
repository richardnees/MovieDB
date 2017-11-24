import XCTest
@testable import MovieDBCore

class MovieTests: XCTestCase {
    let decoder = JSONDecoder()
    let movie1DataURL = Bundle(for: MovieSearchContainerTests.self).url(forResource: "Movie1", withExtension: "json")
    let movie2DataURL = Bundle(for: MovieSearchContainerTests.self).url(forResource: "Movie2", withExtension: "json")

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEquality() {
        
        guard
            let movie1DataURL = movie1DataURL,
            let movie1Data = try? Data(contentsOf: movie1DataURL),
            let movie1 = try? decoder.decode(Movie.self, from: movie1Data),
            let movie2DataURL = movie2DataURL,
            let movie2Data = try? Data(contentsOf: movie2DataURL),
            let movie2 = try? decoder.decode(Movie.self, from: movie2Data)
            else {
                XCTAssert(false)
                return
        }
        
        
        XCTAssertNotEqual(movie1, movie2)
        
    }

    func testReleaseDate() {
        
        guard
            let movie1DataURL = movie1DataURL,
            let movie1Data = try? Data(contentsOf: movie1DataURL),
            let movie1 = try? decoder.decode(Movie.self, from: movie1Data)
            else {
                XCTAssert(false)
                return
        }
        
        XCTAssertNotNil(movie1.releaseDate)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
