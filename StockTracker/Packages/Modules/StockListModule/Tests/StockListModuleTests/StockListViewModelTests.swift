import XCTest
import Entity

@testable import StockListModule

final class StockListViewModelTests: XCTestCase {
    private var sut: StockListViewModel<MockStockListRepository, MockStockListRouting>!
    private var repository: MockStockListRepository!
    private var routing: MockStockListRouting!

    override func setUp() {
        super.setUp()
        self.repository = .init()
        self.routing = .init()
        self.sut = .init(repository: repository)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        repository = nil
        routing = nil
    }

    func test_viewDidLoad() {
        XCTAssertFalse(repository.invokedFetchStocks)
        XCTAssertEqual(repository.invokedFetchStocksCount, 0)

        let stockList = StockList.response
        repository.response = stockList
        sut.viewDidLoad()
        let _ = XCTWaiter.wait(for: [expectation(description: "request")], timeout: 0.1)

        XCTAssertTrue(repository.invokedFetchStocks)
        XCTAssertEqual(repository.invokedFetchStocksCount, 1)
    }

    func test_viewDidLoad_ErrorScenario() {
        repository.response = nil
        sut.viewDidLoad()
        let _ = XCTWaiter.wait(for: [expectation(description: "request")], timeout: 0.1)

        XCTAssertTrue(repository.invokedFetchStocks)
        XCTAssertEqual(repository.invokedFetchStocksCount, 1)
    }

    func test_scrollViewDidScroll_fetchesMoreStocks() {
        let stockList = StockList.response
        repository.response = stockList
        sut.scrollViewDidScroll(contentOffsetY: 500, contentHeight: 500, height: 400)
        let _ = XCTWaiter.wait(for: [expectation(description: "request")], timeout: 0.1)

        XCTAssertTrue(repository.invokedFetchStocks)
        XCTAssertEqual(repository.invokedFetchStocksCount, 1)
    }
}
