import Foundation

extension FileManager {
    public var applicationSupportURL: URL {
        return urls(for: .applicationSupportDirectory, in: .userDomainMask).first ?? URL(fileURLWithPath: "/tmp")
    }
}
