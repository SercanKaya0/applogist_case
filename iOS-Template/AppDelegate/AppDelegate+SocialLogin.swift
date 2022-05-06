//
//  AppDelegate+SocialLogin.swift
//  iOS-Template
//
//  Created by Ercan Garip on 6.05.2022.
//

import Foundation

import GoogleSignIn
import FBSDKCoreKit

extension AppDelegate {
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
    
        let googleSignInHandled = GIDSignIn.sharedInstance.handle(url)
        if googleSignInHandled {
            return googleSignInHandled
        }
        
        let facebookHandled = ApplicationDelegate.shared.application(app, open: url, options: options)
        if facebookHandled {
            return facebookHandled
        }
        return false
    }
}
