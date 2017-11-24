import Foundation

public protocol PropertyListCodableDataSourceProviding: LocalCodableDataSourceProviding {
}

extension PropertyListCodableDataSourceProviding {
    public var decoder: DataSourceDecoder {
        return PropertyListDecoder()
    }

    public var encoder: DataSourceEncoder {
        return PropertyListEncoder()
    }
}

extension PropertyListDecoder: DataSourceDecoder {
    
}

extension PropertyListEncoder: DataSourceEncoder {
    
}

