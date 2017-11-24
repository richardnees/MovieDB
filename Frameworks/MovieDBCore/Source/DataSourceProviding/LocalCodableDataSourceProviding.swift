import Foundation

public protocol DataSourceDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

public protocol DataSourceEncoder {
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}

/// Local Codable Data Source Providing Protocol
public protocol LocalCodableDataSourceProviding: DataSourceProviding {
        
    /// Maximum Items held in store
    var maxItemsCount: Int { get }
    
    /// Local File URL to store
    var storageURL: URL { get }
    
    /// Chosen Decoder
    var decoder: DataSourceDecoder { get }

    /// Chosen Encoder
    var encoder: DataSourceEncoder { get }
    
    /// Called to load store storageURL
    func load()
    
    /// Append item to store
    func append(item: DataSourceItemProtocol)
}

extension LocalCodableDataSourceProviding {
    var maxItemsCount: Int {
        return .max
    }
}
