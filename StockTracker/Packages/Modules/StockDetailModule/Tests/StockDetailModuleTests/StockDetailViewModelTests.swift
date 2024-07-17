import XCTest
import Foundation
import Combine
import Entity
import Extension
import STChart
import Base
import CommonView

@testable import StockDetailModule

final class StockDetailViewModelTests: XCTestCase {
    private var sut: StockDetailViewModel<MockStockDetailRepository, MockStockDetailRouting>!
    private var repository: MockStockDetailRepository!
    private var request: MockStockDetailRequest!
    private var header: MockStockHeaderViewModel!
    private var price: MockStockDetailPriceViewModel!
    private var info: MockStockInfoViewModel!
    private var chart: MockSTLineChartViewModel!
    
    override func setUp() {
        super.setUp()
        self.repository = .init()
        self.request = .init()
        self.header = .init()
        self.price = .init()
        self.info = .init()
        self.chart = .init()
        self.sut = .init(request: request, repository: repository, stockHeaderViewModel: header, stockInfoViewModel: info, stockPriceViewModel: price, stLineChartViewModel: chart)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        repository = nil
        request = nil
        header = nil
        price = nil
        info = nil
        chart = nil
    }
    
    func test_viewDidLoad() {
        XCTAssertFalse(repository.invokedFetchStockDetail)
        XCTAssertEqual(repository.invokedFetchStockDetailCount, 0)
        
        XCTAssertFalse(header.invokedUpdateUIModel)
        XCTAssertEqual(header.invokedUpdateUIModelCount, 0)
        
        XCTAssertFalse(price.invokedUpdateUIModel)
        XCTAssertEqual(price.invokedUpdateUIModelCount, 0)
        
        XCTAssertFalse(info.invokedUpdateUIModel)
        XCTAssertEqual(info.invokedUpdateUIModelCount, 0)
        
        XCTAssertFalse(chart.invokedLoadChart)
        XCTAssertEqual(chart.invokedLoadChartCount, 0)
        
        let response = StockDetail.response
        repository.response = response
        sut.viewDidLoad()
        let  _ = XCTWaiter.wait(for: [expectation(description: "request")], timeout: 0.1)
        
        XCTAssertTrue(repository.invokedFetchStockDetail)
        XCTAssertEqual(repository.invokedFetchStockDetailCount, 1)
        XCTAssertEqual(repository.invokedFetchStockDetailParameters.map(\.request.ticker), response.ticker)
        
        XCTAssertTrue(header.invokedUpdateUIModel)
        XCTAssertEqual(header.invokedUpdateUIModelCount, 1)
        XCTAssertEqual(header.invokedUpdateUIModelParameters.map(\.newModel.logoUrlString), response.logoUrl)
        XCTAssertEqual(header.invokedUpdateUIModelParameters.map(\.newModel.name), response.name)
        
        XCTAssertTrue(info.invokedUpdateUIModel)
        XCTAssertEqual(info.invokedUpdateUIModelCount, 1)
        XCTAssertEqual(info.invokedUpdateUIModelParameters.map(\.newModel.description), response.description)
        
        XCTAssertTrue(chart.invokedLoadChart)
        XCTAssertEqual(chart.invokedLoadChartCount, 1)
        XCTAssertEqual(chart.invokedLoadChartParameters.map(\.data.count), response.stockAggregates.count)
        
        XCTAssertTrue(price.invokedUpdateUIModel)
        XCTAssertEqual(price.invokedUpdateUIModelCount, 1)
        XCTAssertEqual(price.invokedUpdateUIModelParameters.map(\.newModel.price), "\(response.curreny)\(response.closingPrice.toString())")
        XCTAssertEqual(price.invokedUpdateUIModelParameters.map(\.newModel.change), "%\(response.change.toString())")
    }
    
    func test_viewDidLoad_ErrorScenario() {
        sut.viewDidLoad()
        let  _ = XCTWaiter.wait(for: [expectation(description: "request")], timeout: 0.1)
        
        XCTAssertTrue(self.repository.invokedFetchStockDetail)
        XCTAssertEqual(self.repository.invokedFetchStockDetailCount, 1)
        
        XCTAssertFalse(self.header.invokedUpdateUIModel)
        XCTAssertEqual(self.header.invokedUpdateUIModelCount, 0)
        
        XCTAssertFalse(self.price.invokedUpdateUIModel)
        XCTAssertEqual(self.price.invokedUpdateUIModelCount, 0)
        
        XCTAssertFalse(self.info.invokedUpdateUIModel)
        XCTAssertEqual(self.info.invokedUpdateUIModelCount, 0)
        
        XCTAssertFalse(self.chart.invokedLoadChart)
        XCTAssertEqual(self.chart.invokedLoadChartCount, 0)
    }
}
