import Foundation

extension FileManager {
    public static var applicationSupportURL: URL {
        guard let appSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            fatalError("Unable to locate Application Support")
        }
        return appSupportURL
    }
}
