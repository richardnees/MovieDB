import Foundation

public struct Resource<A> {
    public let url: URL
    public var allHTTPHeaderFields: [String : String]?
    public let parse: (Data) -> Result<A>
}

public extension Resource {
    
    public init(url: URL, decode: @escaping (Data) -> Result<A>) {
        self.url = url
        self.parse = { data in
            return decode(data)
        }
    }
}

