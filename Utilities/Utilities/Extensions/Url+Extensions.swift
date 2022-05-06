//
//  Url+Extensions.swift
//  Utilities
//
//  Created by Sercan KAYA on 1.03.2022.
//

import Foundation
import UIKit

public extension URL {
    
    func openURL() {
        if UIApplication.shared.canOpenURL(self) {
            UIApplication.shared.open(self)
        }
    }
}
