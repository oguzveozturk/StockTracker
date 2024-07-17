// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class StockDetailQuery: GraphQLQuery {
  public static let operationName: String = "StockDetail"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query StockDetail($ticker: String!, $limit: Int, $endDate: Date, $startDate: Date, $range: Int, $timespan: String) { stockDetail(ticker: $ticker) { __typename ticker name currency_name description branding { __typename logo_url } stockAggregates( limit: $limit endDate: $endDate startDate: $startDate range: $range timespan: $timespan ) { __typename results { __typename c t } } } }"#
    ))

  public var ticker: String
  public var limit: GraphQLNullable<Int>
  public var endDate: GraphQLNullable<ApolloModels.Date>
  public var startDate: GraphQLNullable<ApolloModels.Date>
  public var range: GraphQLNullable<Int>
  public var timespan: GraphQLNullable<String>

  public init(
    ticker: String,
    limit: GraphQLNullable<Int>,
    endDate: GraphQLNullable<ApolloModels.Date>,
    startDate: GraphQLNullable<ApolloModels.Date>,
    range: GraphQLNullable<Int>,
    timespan: GraphQLNullable<String>
  ) {
    self.ticker = ticker
    self.limit = limit
    self.endDate = endDate
    self.startDate = startDate
    self.range = range
    self.timespan = timespan
  }

  public var __variables: Variables? { [
    "ticker": ticker,
    "limit": limit,
    "endDate": endDate,
    "startDate": startDate,
    "range": range,
    "timespan": timespan
  ] }

  public struct Data: ApolloModels.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { ApolloModels.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("stockDetail", StockDetail?.self, arguments: ["ticker": .variable("ticker")]),
    ] }

    public var stockDetail: StockDetail? { __data["stockDetail"] }

    /// StockDetail
    ///
    /// Parent Type: `StockDetailWithAggregates`
    public struct StockDetail: ApolloModels.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { ApolloModels.Objects.StockDetailWithAggregates }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("ticker", String.self),
        .field("name", String.self),
        .field("currency_name", String?.self),
        .field("description", String?.self),
        .field("branding", Branding?.self),
        .field("stockAggregates", StockAggregates?.self, arguments: [
          "limit": .variable("limit"),
          "endDate": .variable("endDate"),
          "startDate": .variable("startDate"),
          "range": .variable("range"),
          "timespan": .variable("timespan")
        ]),
      ] }

      public var ticker: String { __data["ticker"] }
      public var name: String { __data["name"] }
      public var currency_name: String? { __data["currency_name"] }
      public var description: String? { __data["description"] }
      public var branding: Branding? { __data["branding"] }
      public var stockAggregates: StockAggregates? { __data["stockAggregates"] }

      /// StockDetail.Branding
      ///
      /// Parent Type: `StockDetailBranding`
      public struct Branding: ApolloModels.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ApolloModels.Objects.StockDetailBranding }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("logo_url", String?.self),
        ] }

        public var logo_url: String? { __data["logo_url"] }
      }

      /// StockDetail.StockAggregates
      ///
      /// Parent Type: `StockAggregates`
      public struct StockAggregates: ApolloModels.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { ApolloModels.Objects.StockAggregates }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("results", [Result?]?.self),
        ] }

        public var results: [Result?]? { __data["results"] }

        /// StockDetail.StockAggregates.Result
        ///
        /// Parent Type: `StockAggregatesResult`
        public struct Result: ApolloModels.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { ApolloModels.Objects.StockAggregatesResult }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("c", Double?.self),
            .field("t", Double?.self),
          ] }

          public var c: Double? { __data["c"] }
          public var t: Double? { __data["t"] }
        }
      }
    }
  }
}
