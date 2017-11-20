import Foundation

public struct Resource<A> {
    public let url: URL
    public var allHTTPHeaderFields: [String : String]?
    public let parse: (Data) -> A?
}

public extension Resource {
    public init(url: URL, forwardData: @escaping (Data) -> A?) {
        self.url = url
        self.parse = { data in
            return forwardData(data)
        }
    }
    
    public init(url: URL, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601, decode: @escaping (Data, JSONDecoder) -> A?) {
        self.url = url
        self.parse = { data in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            return decode(data, decoder)
        }
    }
}

