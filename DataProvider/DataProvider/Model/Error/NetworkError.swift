//
//  NetworkError.swift
//  DataProvider
//
//  Created by Sercan Kaya on 3.02.2022.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    
    case timeOut
    case noInternetConnection
    case baseError(Error)
    
    public var errorDescription: String? {
        switch self {
        case .timeOut:
            return "Sunucu geç yanıt veriyor. İnternetiniz yavaşlamış veya sistemimizde bir hata olabilir. Az sonra tekrar deneyiniz"
        case .baseError(let error):
            return error.localizedDescription
        case .noInternetConnection:
            return "No Internet Connection"
        }
    }
}
