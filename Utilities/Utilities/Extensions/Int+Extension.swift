//
//  Int+Extension.swift
//  Utilities
//
//  Created by Sercan KAYA on 8.03.2022.
//

import Foundation

public extension Int {
    
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
