//
//  APIRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih Aslan on 4.11.2020.
//  Copyright © 2020 Mobillium. All rights reserved.
//

public protocol BaseRequest: DecodableResponseRequest {}

// MARK: - RequestEncoding
public extension BaseRequest {
    var encoding: RequestEncoding {
        switch method {
        case .get:
            return .url
        default:
            return .json
        }
    }
}

// MARK: - url
public extension BaseRequest {
    var url: String {
        return "BASE_URL" + path
    }
}

// MARK: - RequestParameters
public extension BaseRequest {
    var parameters: RequestParameters {
        return [:]
    }
}

// MARK: - RequestHeaders
public extension BaseRequest {
    var headers: RequestHeaders {
        return [:]
    }
}
