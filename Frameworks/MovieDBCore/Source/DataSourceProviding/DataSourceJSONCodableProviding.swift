import Foundation

public protocol DataSourceJSONCodableProviding: DataSourceCodableProviding {
}

extension DataSourceJSONCodableProviding {
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

