//
//  BounceAnimation.swift
//  LetzUnite
//
//  Created by Himanshu on 4/5/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

open class BounceAnimation: ItemAnimation {

    open override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        playBounceAnimation(icon)
        textLabel.textColor = textSelectedColor
    }

    open override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        textLabel.textColor = defaultTextColor
        
        /*//To give tint type appearance
        if let iconImage = icon.image {
            let renderMode = defaultIconColor.cgColor.alpha == 0 ? UIImageRenderingMode.alwaysOriginal :
                UIImageRenderingMode.alwaysTemplate
            let renderImage = iconImage.withRenderingMode(renderMode)
            icon.image = renderImage
            icon.tintColor = defaultIconColor
        }
         */
    }
    
    open override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        textLabel.textColor = textSelectedColor
        
        /*//To give tint type appearance
            if let iconImage = icon.image {
                let renderImage = iconImage.withRenderingMode(.alwaysTemplate)
                icon.image = renderImage
                icon.tintColor = iconSelectedColor
            }
         */
    }
    
    func playBounceAnimation(_ icon: UIImageView) {
        let bounceAnimation = CAKeyframeAnimation(keyPath: Constants.AnimationKeys.Scale)
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(duration)
        bounceAnimation.calculationMode = kCAAnimationCubic
        
        icon.layer.add(bounceAnimation, forKey: nil)
        
        /*//To give tint type appearance
        if let iconImage = icon.image {
            let renderImage = iconImage.withRenderingMode(.alwaysTemplate)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        }
         */
    }
    
}
