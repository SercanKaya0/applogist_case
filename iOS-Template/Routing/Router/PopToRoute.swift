//
//  PopToRoute.swift
//  NYT
//
//  Created by Ercan Garip on 30.01.2022.
//

import Foundation

protocol PopToRootRoute {
    func popToRoot(isAnimated: Bool)
}

extension PopToRootRoute where Self: RouterProtocol {
    func popToRoot(isAnimated: Bool = true) {
        guard let navigationController = viewController?.navigationController else {
            return
        }
        navigationController.popToRootViewController(animated: isAnimated)
    }
}
