//
//  UIView+RoundCorners.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/17/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit

// This method is to round the corners of a view
extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
