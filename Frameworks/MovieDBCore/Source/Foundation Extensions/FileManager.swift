import Foundation

extension FileManager {
    
    /// Convenience to get at the Application Support URL. In the very unlikely event this would fail, let redirect to /tmp
    public var applicationSupportURL: URL {
        return urls(for: .applicationSupportDirectory, in: .userDomainMask).first ?? URL(fileURLWithPath: "/tmp")
    }
}
