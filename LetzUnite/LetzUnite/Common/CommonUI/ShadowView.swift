//
//  ShadowView.swift
//  LetzUnite
//
//  Created by Himanshu on 5/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    var cornerRadiusNeeded:Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = false
        
        var shadowPath = UIBezierPath()
        if cornerRadiusNeeded == true {
            shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: shadowViewCornerRadius)
        }else {
            shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 0.0)
        }
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = shadowViewShadowColor
        self.layer.shadowOffset = shadowViewShadowOffset
        self.layer.shadowOpacity = shadowViewShadowOpacity
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shadowRadius = shadowViewCornerRadius
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = shadowViewCornerRadius
    }
}
