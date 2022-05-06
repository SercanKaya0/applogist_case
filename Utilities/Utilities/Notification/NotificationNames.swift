//
//  NotificationNames.swift
//  Utilities
//
//  Created by Ercan Garip on 30.01.2022.
//

import Foundation

public extension Notification.Name {
    static let userIsLoggedIn = Notification.Name(rawValue: "userIsLoggedIn")
    static let hideNytLoader = Notification.Name(rawValue: "hideNytLoader")
    static let scrollToTop = Notification.Name(rawValue: "scrollToTop")
    static let closeLogin = Notification.Name(rawValue: "closeLogin")
    static let screenStatusAppear = Notification.Name(rawValue: "“screenStatusAppear”")
}
