//
//  ItemAnimationProtocol.swift
//  LetzUnite
//
//  Created by Himanshu on 4/5/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

public protocol ItemAnimationProtocol {
    func playAnimation(_ icon: UIImageView, textLabel: UILabel)
    func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor)
    func selectedState(_ icon: UIImageView, textLabel: UILabel)
}


open class ItemAnimation: NSObject, ItemAnimationProtocol {

    struct Constants {
        struct AnimationKeys {
            static let Scale = "transform.scale"
            static let Rotation = "transform.rotation"
            static let KeyFrame = "contents"
            static let PositionY = "position.y"
            static let Opacity = "opacity"
        }
    }
    
    // MARK: properties
    
    //The duration of the animation
    @IBInspectable open var duration: CGFloat = 0.5
    
    //selected state text color.
    @IBInspectable open var textSelectedColor: UIColor = UIColor.red//UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
    
    //selected state icon color.
    @IBInspectable open var iconSelectedColor: UIColor!
    
    //Start animation, method call when UITabBarItem is selected
    open func playAnimation(_: UIImageView, textLabel _: UILabel) {
        fatalError("override method in subclass")
    }
    
    //deselectAnimation, method call when UITabBarItem is unselected
    open func deselectAnimation(_: UIImageView, textLabel _: UILabel, defaultTextColor _: UIColor, defaultIconColor _: UIColor) {
        fatalError("override method in subclass")
    }
    
    //selectedState method call when TabBarController did load
    open func selectedState(_: UIImageView, textLabel _: UILabel) {
        fatalError("override method in subclass")
    }
}
