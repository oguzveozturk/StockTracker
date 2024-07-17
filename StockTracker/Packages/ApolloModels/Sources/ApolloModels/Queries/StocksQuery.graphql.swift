// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class StocksQuery: GraphQLQuery {
  public static let operationName: String = "Stocks"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Stocks($limit: Int, $cursor: String) { stocks(limit: $limit, cursor: $cursor) { __typename data { __typename name ticker } has_more cursor } }"#
    ))

  public var limit: GraphQLNullable<Int>
  public var cursor: GraphQLNullable<String>

  public init(
    limit: GraphQLNullable<Int>,
    cursor: GraphQLNullable<String>
  ) {
    self.limit = limit
    self.cursor = cursor
  }

  public var __variables: Variables? { [
    "limit": limit,
    "cursor": cursor
  ] }

  public struct Data: ApolloModels.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ApolloModels.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("stocks", Stocks?.self, arguments: [
        "limit": .variable("limit"),
        "cursor": .variable("cursor")
      ]),
    ] }

    public var stocks: Stocks? { __data["stocks"] }

    /// Stocks
    ///
    /// Parent Type: `StockList`
    public struct Stocks: ApolloModels.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ApolloModels.Objects.StockList }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("data", [Datum].self),
        .field("has_more", Bool.self),
        .field("cursor", String?.self),
      ] }

      public var data: [Datum] { __data["data"] }
      public var has_more: Bool { __data["has_more"] }
      public var cursor: String? { __data["cursor"] }

      /// Stocks.Datum
      ///
      /// Parent Type: `Stock`
      public struct Datum: ApolloModels.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ApolloModels.Objects.Stock }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String.self),
          .field("ticker", String.self),
        ] }

        public var name: String { __data["name"] }
        public var ticker: String { __data["ticker"] }
      }
    }
  }
}
