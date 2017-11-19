import Foundation

public protocol Request {
    var urlComponents: URLComponents { get }
}

extension Request {
    public var url: URL {
        return urlComponents.url!
    }
}
