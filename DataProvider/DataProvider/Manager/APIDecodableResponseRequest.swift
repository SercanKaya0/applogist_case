//
//  APIRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih Aslan on 4.11.2020.
//  Copyright © 2020 Mobillium. All rights reserved.
//

public protocol NYTRequest: DecodableResponseRequest {}

// MARK: - RequestEncoding
public extension NYTRequest {
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
public extension NYTRequest {
    var url: String {
        return "BASE_URL" + path
    }
}

// MARK: - RequestParameters
public extension NYTRequest {
    var parameters: RequestParameters {
        return [:]
    }
}

// MARK: - RequestHeaders
public extension NYTRequest {
    var headers: RequestHeaders {
        return [:]
    }
}
