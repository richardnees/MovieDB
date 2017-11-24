import Foundation

/// Protocol to ensure `Request` has valid `URLComponents`
public protocol Request {
    var urlComponents: URLComponents { get }
}

extension Request {
    /// `URL` from `urlComponents`
    public var url: URL {
        // FIXME: Don't force unwrap
        return urlComponents.url!
    }
}
