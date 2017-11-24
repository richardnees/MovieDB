import Foundation

public struct Resource<A> {
    public typealias Parser = (Data) -> Result<A>

    public let url: URL
    public var allHTTPHeaderFields: [String : String]?
    public let parse: Parser
}

extension Resource {
    public init(url: URL, decode: @escaping Parser) {
        self.url = url
        self.parse = { data in
            return decode(data)
        }
    }
}
