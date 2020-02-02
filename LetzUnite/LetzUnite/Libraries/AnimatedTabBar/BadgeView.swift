//
//  BadgeView.swift
//  LetzUnite
//
//  Created by Himanshu on 4/5/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

open class BadgeView: UILabel {

    internal var topConstraint: NSLayoutConstraint?
    internal var centerXConstraint: NSLayoutConstraint?
    
    open class func badge() -> BadgeView {
        return BadgeView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.backgroundColor = UIColor.red.cgColor
        layer.cornerRadius = frame.size.width / 2
        
        configureNumberLabel()
        
        translatesAutoresizingMaskIntoConstraints = false
        
        createSizeConstraints(frame.size)
    }
    
    open override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += 10.0
        return contentSize
    }
    
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    internal func createSizeConstraints(_ size: CGSize) {
        let widthConstraint = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutAttribute.width,
            relatedBy: NSLayoutRelation.greaterThanOrEqual,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: size.width)
        addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: size.height)
        addConstraint(heightConstraint)
    }
    
    fileprivate func configureNumberLabel() {
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 13)
        textColor = UIColor.white
    }
    
    open func addBadgeOnView(_ onView: UIView) {
        
        onView.addSubview(self)
        
        topConstraint = NSLayoutConstraint(item: self,
                                           attribute: NSLayoutAttribute.top,
                                           relatedBy: NSLayoutRelation.equal,
                                           toItem: onView,
                                           attribute: NSLayoutAttribute.top,
                                           multiplier: 1,
                                           constant: 3)
        onView.addConstraint(topConstraint!)
        
        centerXConstraint = NSLayoutConstraint(item: self,
                                               attribute: NSLayoutAttribute.centerX,
                                               relatedBy: NSLayoutRelation.equal,
                                               toItem: onView,
                                               attribute: NSLayoutAttribute.centerX,
                                               multiplier: 1,
                                               constant: 10)
        onView.addConstraint(centerXConstraint!)
    }

}
