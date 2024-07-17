//
//  AppCoordinator.swift
//  StockTracker
//
//  Created by oguzozturk on 8.06.2024.
//

import UIKit
import Coordinator
import GraphQLClient
import StockListModule

final class AppCoordinator: PresentationCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController = AppRootViewController()
    let client = GraphQLClientFactory().interViewClient
    
    init(window: UIWindow) {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func start() {
        let stockListViewCoordinator = StockListViewCoordinator(client: client)
        addChildCoordinator(stockListViewCoordinator)
        stockListViewCoordinator.start()
        rootViewController.set(childViewController: stockListViewCoordinator.rootViewController)
    }
}
