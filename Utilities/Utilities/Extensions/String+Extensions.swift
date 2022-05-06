//
//  String+Extensions.swift
//  Utilities
//
//  Created by Ercan Garip on 8.04.2022.
//

import Foundation

public extension String {
    
    var nytUrl: URL? {
        let stringUrl = self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        if let stringUrl = stringUrl {
            return URL(string: stringUrl)
        } else {
            return nil
        }
    }
}
