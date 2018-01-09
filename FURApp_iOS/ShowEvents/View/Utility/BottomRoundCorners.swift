//
//  UIView+RoundCorners.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/26/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation
import UIKit

class BottomRoundCorners: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 14.0, height: 14.0))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
    }
}
