import Foundation

public protocol DataSourceDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

public protocol DataSourceEncoder {
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}

public protocol CodableDataSourceProviding: DataSourceProviding {
    var maxItemsCount: Int { get }
    var storageURL: URL { get }
    var decoder: DataSourceDecoder { get }
    var encoder: DataSourceEncoder { get }
    func load()
    func flush()
    func append(item: DataSourceDisplayableItem)
}
