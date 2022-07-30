//
//  StackView+Extensions.swift
//  UIComponents
//
//  Created by sercan kaya on 27.07.2022.
//

import Foundation

public extension UIStackView {
    
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }
}
