//
//  AppRouter.swift
//  NYT
//
//  Created by Ercan Garip on 25.11.2021.
//

import UIKit

final class AppRouter: Router, AppRouter.Routes {
    
    typealias Routes = ExampleRoute
    
    weak var window: UIWindow?
    
    func topViewController() -> UIViewController? {
        return UIApplication.topViewController()
    }
    
    static let shared = AppRouter()

    override func open(_ viewController: UIViewController, transition: Transition) {
        self.viewController = topViewController()
        super.open(viewController, transition: transition)
    }
    
    func startApp() {
        AppRouter.shared.presentExample()
    }
}
