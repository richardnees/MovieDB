import Foundation

public protocol DataSourcePropertyListCodableProviding: DataSourceCodableProviding {
}

extension DataSourcePropertyListCodableProviding {
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

