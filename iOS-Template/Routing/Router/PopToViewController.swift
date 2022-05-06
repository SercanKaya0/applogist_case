//
//  PopToViewController.swift
//  NYT
//
//  Created by Ercan Garip on 30.01.2022.
//

import Foundation
import UIKit

protocol PopToViewController {
    func popToViewController<T: UIViewController>(typeClass: T.Type, isAnimated: Bool)
}
extension PopToViewController where Self: RouterProtocol {
    
    func popToViewController<T: UIViewController>(typeClass: T.Type, isAnimated: Bool = true) {
        guard let navigationController = self.viewController?.navigationController else {
            return
        }
        if let viewController = navigationController.viewControllers.first(where: { $0 is T }) {
            navigationController.popToViewController(viewController, animated: isAnimated)
        } else {
            navigationController.popToRootViewController(animated: isAnimated)
        }
    }
}
