import Foundation

/// Generic resource.
public struct Resource<A> {
    public typealias Parser = (Data) -> Result<A>

    /// Request URL
    public let url: URL

    /// Optional HTTP header fields
    public var allHTTPHeaderFields: [String : String]?
    
    /// Parse function to decode
    public let parse: Parser
}

extension Resource {

    /// Creates a generic `Resource` instance from a `URL`.
    ///
    /// - parameter url:    URL
    /// - parameter decode: Parse function to decode
    ///
    /// - returns: The new `Resource` instance.
    public init(url: URL, decode: @escaping Parser) {
        self.url = url
        self.parse = { data in
            return decode(data)
        }
    }
}
