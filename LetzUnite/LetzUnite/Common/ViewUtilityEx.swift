//
//  ViewUtilityEx.swift
//  LetzUnite
//
//  Created by B0081006 on 7/7/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func applyArrowDialogAppearanceWithOrientation(arrowOrientation: UIImageOrientation) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path =  dialogBezierPathWithFrame(self.frame, arrowOrientation: arrowOrientation).cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        self.layer.mask = shapeLayer
    }
}
