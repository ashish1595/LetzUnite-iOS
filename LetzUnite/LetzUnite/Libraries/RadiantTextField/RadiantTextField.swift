//
//  RadiantTextField.swift
//  LetzUnite
//
//  Created by Himanshu on 4/19/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

class RadiantTextField: UITextField {
    
    var borderColor: UIColor?
    public var _borderColor:UIColor? {
        get {
            return UIColor(cgColor: (self.borderColor?.cgColor)!)
        }
        
        set (newValue){
            self.borderColor? = UIColor(cgColor: (newValue?.cgColor)!)
            if self.isFirstResponder != true && self.alwaysLighting != true {
                self.layer.borderColor = self.borderColor?.cgColor
            }
        }
    }
    
    var lightColor: UIColor?
    var _lightColor : UIColor? {
        get {
            return lightColor
        }
        set (newValue) {
            if self.isFirstResponder == true || self.alwaysLighting == true {
                self.animateBorderColorFrom(fromColor: self.layer.borderColor!, toColor: lightColor?.cgColor ?? UIColor.red.cgColor, fromOpacity: 1.0, toOpacity: 1.0)
            }
            lightColor? = UIColor(cgColor: (newValue?.cgColor)!)
            self.layer.shadowColor = lightColor?.cgColor
        }
    }
    
    
    var alwaysLighting: Bool?
    var _alwaysLighting : Bool? {
        get {
            return alwaysLighting
        }
        set (newValue) {
            if alwaysLighting == true && newValue != true && self.isFirstResponder != true {
                //hideGlowing
                self.hideLighting()
            }else if(alwaysLighting != true && newValue == true && self.isFirstResponder != true) {
                //showGlowing
                self.showLighting()
            }
            
            alwaysLighting? = Bool((newValue)!)
        }
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.alwaysLighting = false
        self.configureView()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.alwaysLighting = false
        self.configureView()
    }
    
   override var borderStyle: UITextBorderStyle {
        set {
            super.borderStyle = .none
        }
        
        get {
            return UITextBorderStyle(rawValue: self.borderStyle.rawValue)!
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor?.set()
        UIBezierPath(roundedRect: self.bounds, cornerRadius: 4.0).fill()
    }
    
    func configureView() {
        self.borderStyle = .none
        self.clipsToBounds = true
        self.alwaysLighting = false

        if self.backgroundColor == nil {
            self.backgroundColor = .white
        }
        
        if self.lightColor == nil {
            self.lightColor = UIColor.init(red: 255.0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.2)
        }
        
        if self.borderColor == nil {
            self.borderColor = UIColor.clear
        }
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = self.borderColor?.cgColor
        
        self.layer.shadowColor = self.lightColor?.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 4.0).cgPath
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    func animateBorderColorFrom(fromColor:Any, toColor:Any, fromOpacity:Any, toOpacity:Any) {
        let borderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        borderColorAnimation.fromValue = fromColor
        borderColorAnimation.toValue = toColor
        
        let shadowOpacityAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        shadowOpacityAnimation.fromValue = fromOpacity
        shadowOpacityAnimation.toValue = toOpacity
        
        let group = CAAnimationGroup()
        group.duration = 1.0 / 3.0
        group.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        group.animations = [borderColorAnimation, shadowOpacityAnimation]
        self.layer.add(group, forKey: nil)
    }
    
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        
        if (result && self.alwaysLighting! != true)
        {
            //showGlowing
            self.showLighting()
        }
        return result;
    }
    
    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        
        if (result && self.alwaysLighting! != true)
        {
            //hideGlowing
            self.hideLighting()
        }
        return result;
    }

    
    func showLighting() {
        self.animateBorderColorFrom(fromColor: self.borderColor!, toColor: self.layer.shadowColor!, fromOpacity: NSNumber(value: 0.0), toOpacity: NSNumber(value: 1.0))
    }
    
    func hideLighting() {
        self.animateBorderColorFrom(fromColor: self.borderColor!, toColor: self.borderColor?.cgColor ?? UIColor.red.cgColor, fromOpacity: NSNumber(value: 1.0), toOpacity: NSNumber(value: 0.0))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 2)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 2)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 2)
    }
    
}
