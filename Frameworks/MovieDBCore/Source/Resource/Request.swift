import Foundation

public protocol Request {
    var urlComponents: URLComponents { get }
}

extension Request {
    public var url: URL {
        // FIXME: Don't force unwrap
        return urlComponents.url!
    }
}
