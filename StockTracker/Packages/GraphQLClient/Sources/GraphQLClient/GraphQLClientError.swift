import Foundation

public enum GraphQLClientError: Error, LocalizedError {
    case serverError(String)
    case tooManyRequests

    init(_ error: Error) {
        if error.localizedDescription == "429: Too Many Requests" {
            self = .tooManyRequests
        } else {
            self = .serverError(error.localizedDescription)
        }
    }

    public var errorDescription: String? {
        switch self {
        case .serverError(let message):
            return "Server error: \(message)"
        case .tooManyRequests:
            return "Too many requests. Please try again later."
        }
    }
}
