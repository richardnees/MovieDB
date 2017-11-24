import Foundation

public protocol JSONCodableDataSourceProviding: LocalCodableDataSourceProviding {
}

extension JSONCodableDataSourceProviding {
    public var decoder: DataSourceDecoder {
        return JSONDecoder()
    }

    public var encoder: DataSourceEncoder {
        return JSONEncoder()
    }
}

extension JSONDecoder: DataSourceDecoder {
    
}

extension JSONEncoder: DataSourceEncoder {
    
}

