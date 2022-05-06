//
//  DataProviderProtocol.swift
//  DataProvider
//
//  Created by Mehmet Salih Aslan on 4.11.2020.
//  Copyright © 2020 Mobillium. All rights reserved.
//

public typealias DataProviderResult<T: Decodable> = ((Result<T, NetworkError>) -> Void)

public protocol DataProviderProtocol {
    
    func request<T: DecodableResponseRequest>(for request: T,
                                              result: DataProviderResult<T.ResponseType>?)
    func uploadRequest<T: DecodableResponseRequest>(for request: T,
                                                    files: [MultiPartFileData],
                                                    result: DataProviderResult<T.ResponseType>?)
}
