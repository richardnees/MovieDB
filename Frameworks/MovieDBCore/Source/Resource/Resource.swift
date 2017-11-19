import Foundation

public struct Resource<A> {
    public let url: URL
    public var allHTTPHeaderFields: [String : String]?
    public let parse: (Data) throws -> A
}

public extension Resource {
    public init(url: URL, forwardData: @escaping (Data) -> A) {
        self.url = url
        self.parse = { data in
            return forwardData(data)
        }
    }
    
    public init(url: URL, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601, decodeJSON: @escaping (Data, JSONDecoder) throws -> A) {
        self.url = url
        self.parse = { data in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            return try decodeJSON(data, decoder)
        }
    }
}
