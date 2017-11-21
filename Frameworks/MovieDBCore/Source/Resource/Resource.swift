import Foundation

public struct Resource<A> {
    public let url: URL
    public var allHTTPHeaderFields: [String : String]?
    public let parse: (Data) -> A?
}

public extension Resource {    
    public init(url: URL, decode: @escaping (Data) -> A?) {
        self.url = url
        self.parse = { data in
            return decode(data)
        }
    }
}

