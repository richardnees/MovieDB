import Foundation

extension APIClient {
    /// HTTP Status codes errors
    public enum HTTPStatusError: Error {
        case httpError(code: Int)
    }
}

extension APIClient.HTTPStatusError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case let .httpError(code):
            let localizedHTTStatusCodeString = HTTPURLResponse.localizedString(forStatusCode: code)
            return NSLocalizedString("HTTP Error \(code)\n\(localizedHTTStatusCodeString)", comment: "Needs comment")
        }
    }
}

extension APIClient.HTTPStatusError: CustomNSError {
    public static var errorDomain: String {
        return "APIClient.HTTPStatusError"
    }
    
    public var errorCode: Int {
        switch self {
        case let .httpError(code):
            return code
        }
    }
    
    public var errorUserInfo: [String : Any] {
        switch self {
        case .httpError(_):
            return [:]
        }
    }
}
