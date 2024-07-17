import Apollo
import ApolloAPI
import Foundation
import Combine
import ApolloCombine

public protocol GraphQLClientProtocol {
    func request<Query: GraphQLQuery>(for query: Query, cachePolicy: CachePolicy) -> AnyPublisher<Query.Data, GraphQLClientError>
}

public final class GraphQLClient: GraphQLClientProtocol {
    private let client: ApolloClientProtocol
    
    public init(client: ApolloClientProtocol) {
        self.client = client
    }
    
    public func request<Query: GraphQLQuery>(for query: Query, cachePolicy: CachePolicy) -> AnyPublisher<Query.Data, GraphQLClientError> {
        client.fetchPublisher(query: query)
            .tryMap { gqlResult in
                if let firstError = gqlResult.errors?.first {
                    throw firstError
                } else {
                    guard let data = gqlResult.data else {
                        throw GraphQLClientError.serverError("Empty data")
                    }
                    return data
                }
            }
            .mapError { GraphQLClientError($0) }
            .eraseToAnyPublisher()
    }
}

public enum ApolloError: LocalizedError {
    case invalidEndpointURL
    case responseError

    public var errorDescription: String? {
        switch self {
        case .invalidEndpointURL:
            return "Invalid GraphQL endpoint"
        case .responseError:
            return "GraphQL response included errors"
        }
    }
}
