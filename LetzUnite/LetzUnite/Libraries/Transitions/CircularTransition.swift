//
//  CircularTransition.swift
//  LetzUnite
//
//  Created by Himanshu on 4/7/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

open class CircularTransition: NSObject {
    
    open var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }

    open var duration = 0.5
    
    open var transitionMode: CircularTransitionMode = .present
    
    open var circleColor: UIColor = .white
    
    open fileprivate(set) var circle = UIView()
    
    @objc public enum CircularTransitionMode: Int {
        case present, dismiss, pop
    }
}

extension CircularTransition: UIViewControllerAnimatedTransitioning {
    
    // MARK: - UIViewControllerAnimatedTransitioning
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        
        fromViewController?.beginAppearanceTransition(false, animated: true)
        toViewController?.beginAppearanceTransition(true, animated: true)

        if transitionMode == .present {
            let presentedControllerView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
            let originalCenter = presentedControllerView.center
            let originalSize = presentedControllerView.frame.size
            
            circle = UIView()
            circle.frame = frameForCircle(originalCenter, size: originalSize, start: startingPoint)
            circle.layer.cornerRadius = circle.frame.size.height / 2
            circle.center = startingPoint
            circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            circle.backgroundColor = circleColor
            containerView.addSubview(circle)
            
            presentedControllerView.center = startingPoint
            presentedControllerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            presentedControllerView.alpha = 0
            containerView.addSubview(presentedControllerView)
            
            UIView.animate(withDuration: duration, animations: {
                self.circle.transform = CGAffineTransform.identity
                presentedControllerView.transform = CGAffineTransform.identity
                presentedControllerView.alpha = 1
                presentedControllerView.center = originalCenter
            }, completion: { (_) in
                transitionContext.completeTransition(true)
                self.circle.isHidden = true
                
                fromViewController?.endAppearanceTransition()
                toViewController?.endAppearanceTransition()

            })
        } else {
            let key = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            let returningControllerView = transitionContext.view(forKey: key)!
            let originalCenter = returningControllerView.center
            let originalSize = returningControllerView.frame.size
            
            circle.frame = frameForCircle(originalCenter, size: originalSize, start: startingPoint)
            circle.layer.cornerRadius = circle.frame.size.height / 2
            circle.center = startingPoint
            circle.isHidden = false
            circle.backgroundColor = circleColor

            UIView.animate(withDuration: duration, animations: {
                self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returningControllerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returningControllerView.center = self.startingPoint
                returningControllerView.alpha = 0

                if self.transitionMode == .pop {
                    containerView.insertSubview(returningControllerView, belowSubview: returningControllerView)
                    containerView.insertSubview(self.circle, belowSubview: returningControllerView)
                }
            }, completion: { (_) in
                returningControllerView.center = originalCenter
                returningControllerView.removeFromSuperview()
                self.circle.removeFromSuperview()
                transitionContext.completeTransition(true)
                
                fromViewController?.endAppearanceTransition()
                toViewController?.endAppearanceTransition()
            })
        }
    }
}

private extension CircularTransition {
    func frameForCircle(_ originalCenter: CGPoint, size originalSize: CGSize, start: CGPoint) -> CGRect {
        let lengthX = fmax(start.x, originalSize.width - start.x)
        let lengthY = fmax(start.y, originalSize.height - start.y)
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
}



