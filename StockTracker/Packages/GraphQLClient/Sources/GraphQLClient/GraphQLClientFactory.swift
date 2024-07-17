import Foundation
import ApolloModels
import Entity
import ApolloCombine
import Apollo
import Combine

public final class GraphQLClientFactory {
    public enum ClientType {
        case interViewApi
        
        var baseUrl: URL {
            switch self {
            case .interViewApi:
                return URL(string: "https://your-api-url.com/")!
            }
        }
    }
    
    public lazy var interViewClient: GraphQLClientProtocol = {
        makeNetworkService(clientType: .interViewApi)
    }()
    
    public init(){}
}

private extension GraphQLClientFactory {
    func makeNetworkService(clientType: ClientType) -> GraphQLClientProtocol {
        let client: ApolloClientProtocol = {
            let cache = CustomInMemoryCache()
            let store = ApolloStore(cache: cache)
            let configuration: URLSessionConfiguration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 15
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
            configuration.urlCache = nil
            
            let sessionClient = URLSessionClient(sessionConfiguration: configuration)
            
            let provider = DefaultInterceptorProvider(
                client: sessionClient,
                shouldInvalidateClientOnDeinit: true,
                store: store
            )
            let requestChainTransport = RequestChainNetworkTransport(
                interceptorProvider: provider,
                endpointURL: clientType.baseUrl
            )
            
            return ApolloClient(
                networkTransport: requestChainTransport,
                store: store
            )
        }()
        return GraphQLClient(client: client)
    }
}
