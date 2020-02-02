//
//  AnimatedTabBarItem.swift
//  LetzUnite
//
//  Created by Himanshu on 4/5/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

open class AnimatedTabBarItem: UITabBarItem {
    
    // Container for icon and text in UITabBarItem.
    open var iconView: (icon: UIImageView, textLabel: UILabel)?
    // use badgeValue to show badge
    
    open override var isEnabled: Bool {
        didSet {
            iconView?.icon.alpha = isEnabled == true ? 1 : 0.5
            iconView?.textLabel.alpha = isEnabled == true ? 1 : 0.5
        }
    }
    
    open var badge: BadgeView?
    
    open var bgDefaultColor: UIColor = UIColor.clear
    open var bgSelectedColor: UIColor = UIColor.clear
    
    open var tabBarImage: (UIImage)?
    open var tabBarSelectedImage: (UIImage)?
    
    /// The color of the UITabBarItem text.
    @IBInspectable open var textColor: UIColor = UIColor.black
    /// The tint color of the UITabBarItem icon.
    @IBInspectable open var iconColor: UIColor = UIColor.clear
    
    /// The font used to render the UITabBarItem text.
    open var textFont: UIFont = UIFont.systemFont(ofSize: 10)
    
    @IBOutlet open var animation: ItemAnimation!

    @IBInspectable open var yOffSet: CGFloat = 0

    
    /**
     Start selected animation
     */
    open func playAnimation() {

        assert(animation != nil, "animation not added in UITabBarItem")
        guard animation != nil && iconView != nil else {
            return
        }
        
        iconView?.icon.image = self.tabBarSelectedImage
        
        animation.playAnimation(iconView!.icon, textLabel: iconView!.textLabel)
    }
    
    /**
     Start unselected animation
     */
    open func deselectAnimation() {
        
        guard animation != nil && iconView != nil else {
            return
        }
        
        iconView?.icon.image = self.tabBarImage
        
        animation.deselectAnimation(
            iconView!.icon,
            textLabel: iconView!.textLabel,
            defaultTextColor: textColor,
            defaultIconColor: iconColor)
    }
    
    /**
     Set selected state without animation
     */
    open func selectedState() {
        guard animation != nil && iconView != nil else {
            return
        }
        
        animation.selectedState(iconView!.icon, textLabel: iconView!.textLabel)
    }
}


extension AnimatedTabBarItem {
    
    open override var badgeValue: String? {
        get {
            return badge?.text
        }
        set(newValue) {
            
            if newValue == nil {
                badge?.removeFromSuperview()
                badge = nil
                return
            }
            
            if let iconView = iconView, let contanerView = iconView.icon.superview, badge == nil {
                badge = BadgeView.badge()
                badge!.addBadgeOnView(contanerView)
            }
            
            badge?.text = newValue
        }
    }
}



