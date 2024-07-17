//
//  AppRootViewController.swift
//  StockTracker
//
//  Created by oguzozturk on 8.06.2024.
//

import UIKit
import Extension

final class AppRootViewController: UIViewController {
    
    func set(childViewController controller: UIViewController) {
        addChild(controller)
        controller.didMove(toParent: self)
        let childView = controller.view!
        view.addSubview(childView)
        childView.equalToSuperView()
    }
}
