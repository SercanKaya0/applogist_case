//
//  BigAreaButton.swift
//  UIComponents
//
//  Created by Sercan KAYA on 31.07.2022.
//

import UIKit

public class BigAreaButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
          return bounds.insetBy(dx: -20, dy: -20).contains(point)
      }
}
