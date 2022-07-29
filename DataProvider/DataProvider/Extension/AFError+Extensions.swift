//
//  AFError+Extensions.swift
//  DataProvider
//
//  Created by Sercan Kaya on 5.02.2022.
//

import Foundation
import Alamofire

extension AFError {
    var isTimeout: Bool {
        if isSessionTaskError,
           let error = underlyingError as NSError?, error.code == NSURLErrorTimedOut {
            return true
        }
        return false
    }
}
