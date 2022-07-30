//
//  ApiRequestInterceptor.swift
//  SampleProject
//
//  Created by Mehmet Salih Aslan on 15.11.2021.
//  Copyright © 2021 Mobillium. All rights reserved.
//

import Alamofire

public class APIRequestInterceptor: RequestInterceptor {
    
    public static let shared = APIRequestInterceptor()
    let retryLimit = 1
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let adaptedRequest = urlRequest
        completion(.success(adaptedRequest))
    }
}
