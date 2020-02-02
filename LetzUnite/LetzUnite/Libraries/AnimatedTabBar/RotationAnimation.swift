//
//  RotationAnimation.swift
//  LetzUnite
//
//  Created by Himanshu on 4/6/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

class LeftRotationAnimation: RotationAnimation {
    override init() {
        super.init()
        direction = RotationDirection.left
    }
}

class RightRotationAnimation: RotationAnimation {
    override init() {
        super.init()
        direction = RotationDirection.right
    }
}

class RotationAnimation: ItemAnimation {

    public enum RotationDirection {
        case left
        case right
    }
    
    //Animation direction
    open var direction: RotationDirection!
    
    //playAnimation, method call when UITabBarItem is selected
    open override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        playRoatationAnimation(icon)
        textLabel.textColor = textSelectedColor
    }
    
    //deselectAnimation, method call when UITabBarItem is unselected
    open override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        textLabel.textColor = defaultTextColor
        
        if let iconImage = icon.image {
            let renderMode = defaultIconColor.cgColor.alpha == 0 ? UIImageRenderingMode.alwaysOriginal :
                UIImageRenderingMode.alwaysTemplate
            let renderImage = iconImage.withRenderingMode(renderMode)
            icon.image = renderImage
            icon.tintColor = defaultIconColor
        }
    }
    
    //selectedState method call when TabBarController did load
    open override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        textLabel.textColor = textSelectedColor
        
        if let iconImage = icon.image {
            let renderImage = iconImage.withRenderingMode(.alwaysTemplate)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }
    
    func playRoatationAnimation(_ icon: UIImageView) {
        
        let rotateAnimation = CABasicAnimation(keyPath: Constants.AnimationKeys.Rotation)
        rotateAnimation.fromValue = 0.0
        
        var toValue = CGFloat.pi * 2
        if direction != nil && direction == RotationDirection.left {
            toValue = toValue * -1.0
        }
        
        rotateAnimation.toValue = toValue
        rotateAnimation.duration = TimeInterval(duration)
        
        icon.layer.add(rotateAnimation, forKey: nil)
        
        if let iconImage = icon.image {
            let renderImage = iconImage.withRenderingMode(.alwaysTemplate)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        }
    }
    
}



