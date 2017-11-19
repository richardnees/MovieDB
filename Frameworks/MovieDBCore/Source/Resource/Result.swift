import Foundation

public enum Result<A> {
    case success(A)
    case failure(Error)
}

