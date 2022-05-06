//
//  Transition.swift
//  NYT
//
//  Created by Ercan Garip on 25.11.2021.
//

import Foundation
import UIKit

protocol Transition: AnyObject {
    var viewController: UIViewController? { get set }

    func open(_ viewController: UIViewController)
    func close(_ viewController: UIViewController)
}
