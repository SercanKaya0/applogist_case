//
//  Formatter+Extension.swift
//  Utilities
//
//  Created by Sercan KAYA on 8.03.2022.
//

import Foundation

public extension Formatter {
    
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
}
