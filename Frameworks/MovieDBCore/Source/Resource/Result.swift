import Foundation

public enum Result<A> {
    case success(A)
    case error(Error)
}
