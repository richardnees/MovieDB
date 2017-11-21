import Foundation

public protocol JSONCodableDataSourceProviding: CodableDataSourceProviding {
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

