//
//  Typealias.swift
//  DataProvider
//
//  Created by Mehmet Salih Aslan on 4.11.2020.
//  Copyright © 2020 Mobillium. All rights reserved.
//

public typealias RequestParameters = [String: Any]
public typealias RequestHeaders = [String: String]

extension RequestParameters {
    
    mutating func setToken() {
        if let user = UserCacheHelper.get() {
            self["token"] = user.token
        }
    }
}
