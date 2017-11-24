import Foundation

extension APIClient {
    /// Basic parsing errors
    public enum ParsingError: Error {
        case noData
        case imageCreationFailed
    }
}

extension APIClient.ParsingError: LocalizedError {
    public var ParsingError: String {
        switch self {
        case .noData:
            return NSLocalizedString("No data to parse", comment: "Needs comment")
        case .imageCreationFailed:
            return NSLocalizedString("Unable to create image from data", comment: "Needs comment")
        }
    }
}

extension APIClient.ParsingError: CustomNSError {
    
    public static var errorDomain: String {
        return "APIClient.ParsingError"
    }
    
    public var errorCode: Int {
        switch self {
        case .noData:
            return 1000
        case .imageCreationFailed:
            return 2000
        }
    }
    
    public var errorUserInfo: [String : Any] {
        switch self {
        case .noData:
            return [:]
        case .imageCreationFailed:
            return [:]
        }
    }
}
