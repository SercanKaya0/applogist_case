//
//  HomeRequest.swift
//  DataProvider
//
//  Created by Sercan KAYA on 29.07.2022.
//

public struct HomeRequest: BaseRequest {
    
    public typealias ResponseType = [Home]?
    
    public var path: String = "list"
    public var method: RequestMethod = .get
    public var parameters: RequestParameters = [:]
    public var headers: RequestHeaders = [:]
    
    public init() {}
    
}
