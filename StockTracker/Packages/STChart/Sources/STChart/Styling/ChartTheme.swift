//
//  File.swift
//  
//
//  Created by oguzozturk on 9.06.2024.
//

import UIKit

public enum ChartTheme {
    case green, orange

    public var color: UIColor {
        switch self {
        case .green:
            return .systemGreen
        case .orange:
            return .systemOrange
        }
    }
}
