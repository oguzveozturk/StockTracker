// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == ApolloModels.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == ApolloModels.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == ApolloModels.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == ApolloModels.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Query": return ApolloModels.Objects.Query
    case "StockList": return ApolloModels.Objects.StockList
    case "Stock": return ApolloModels.Objects.Stock
    case "StockDetailWithAggregates": return ApolloModels.Objects.StockDetailWithAggregates
    case "StockDetailBranding": return ApolloModels.Objects.StockDetailBranding
    case "StockAggregates": return ApolloModels.Objects.StockAggregates
    case "StockAggregatesResult": return ApolloModels.Objects.StockAggregatesResult
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
