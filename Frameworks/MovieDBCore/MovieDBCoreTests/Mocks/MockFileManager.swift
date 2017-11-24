import Foundation
@testable import MovieDBCore

class MockFileManager: FileManager {
    var testURLs: [URL] = []
    
    override func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL] {
        return testURLs
    }
}
