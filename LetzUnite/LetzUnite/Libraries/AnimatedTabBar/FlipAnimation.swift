//
//  FlipAnimation.swift
//  LetzUnite
//
//  Created by Himanshu on 4/6/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

class FlipAnimation: ItemAnimation {

    //Default TransitionNone
    open var transitionOptions: UIViewAnimationOptions!
    
    override init() {
        super.init()
        transitionOptions = UIViewAnimationOptions()
    }
    
    //playAnimation, method call when UITabBarItem is selected
    open override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        textLabel.textColor = textSelectedColor

        
        /*
        selectedColor(icon, textLabel: textLabel)
        */
        
        UIView.transition(with: icon, duration: TimeInterval(duration), options: transitionOptions, animations: {
        }, completion: { _ in
        })
    }
    
    //deselectAnimation, method call when UITabBarItem is unselected
    open override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        textLabel.textColor = defaultTextColor

        /*
        if let iconImage = icon.image {
            let renderMode = defaultIconColor.cgColor.alpha == 0 ? UIImageRenderingMode.alwaysOriginal :
                UIImageRenderingMode.alwaysTemplate
            let renderImage = iconImage.withRenderingMode(renderMode)
            icon.image = renderImage
            icon.tintColor = defaultIconColor
        }
        textLabel.textColor = defaultTextColor
         */
    }
    
    //selectedState will call when TabBarController did load
    open override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        textLabel.textColor = textSelectedColor

        /*
        selectedColor(icon, textLabel: textLabel)
         */
    }
    
    func selectedColor(_ icon: UIImageView, textLabel: UILabel) {
        if let iconImage = icon.image, iconSelectedColor != nil {
            let renderImage = iconImage.withRenderingMode(.alwaysTemplate)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        }
        textLabel.textColor = textSelectedColor
    }
}


class FlipLeftAnimation: FlipAnimation {
    override init() {
        super.init()
        transitionOptions = UIViewAnimationOptions.transitionFlipFromLeft
    }
}

class FlipRightAnimation: FlipAnimation {
    override init() {
        super.init()
        transitionOptions = UIViewAnimationOptions.transitionFlipFromRight
    }
}

class FlipTopAnimation: FlipAnimation {
    override init() {
        super.init()
        transitionOptions = UIViewAnimationOptions.transitionFlipFromTop
    }
}

class FlipBottomAnimation: FlipAnimation {
    override init() {
        super.init()
        transitionOptions = UIViewAnimationOptions.transitionFlipFromBottom
    }
}

