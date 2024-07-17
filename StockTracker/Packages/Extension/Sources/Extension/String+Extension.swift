//
//  File.swift
//  
//
//  Created by oguzozturk on 10.06.2024.
//

import Foundation

extension String {
    public var asURL: URL? {
        URL(string: self)
    }
}
