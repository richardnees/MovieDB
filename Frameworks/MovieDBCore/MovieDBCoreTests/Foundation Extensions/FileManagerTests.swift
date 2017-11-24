import XCTest
@testable import MovieDBCore

class FileManagerTests: XCTestCase {
    var subject: MockFileManager!
    
    override func setUp() {
        super.setUp()
        subject = MockFileManager()
    }

    func testApplicationSupportURL() {
        subject.testURLs = [URL(fileURLWithPath: "/Library/Something/Application Support")]
        let appSupportURL = subject.applicationSupportURL
        
        let expectedLastPathComponent = "Application Support"
        
        XCTAssertEqual(appSupportURL.lastPathComponent, expectedLastPathComponent)
    }

    func testApplicationSupportURLRedirectToTemp() {
        subject.testURLs = []
        let appSupportURL = subject.applicationSupportURL
        
        let expectedURL = URL(fileURLWithPath: "/tmp")
        
        XCTAssertEqual(appSupportURL, expectedURL)
    }
}
