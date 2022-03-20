//
//  ReusableView.swift
//  UIComponents
//
//  Created by Ercan Garip on 15.11.2021.
//

import UIKit

public class ReusableViewModel {
    public init() {
        
    }
}

public protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
