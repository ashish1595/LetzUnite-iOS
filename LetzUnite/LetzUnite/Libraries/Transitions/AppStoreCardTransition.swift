//
//  AppStoreCardTransition.swift
//  LetzUnite
//
//  Created by B0081006 on 7/11/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

class AppStoreCardTransition: NSObject {
    
    open var startingPoint = CGPoint.zero {
        didSet {
            cardView.center = startingPoint
        }
    }
    
    open var startingFrame = CGRect.zero {
        didSet {
            cardView.frame = startingFrame
        }
    }
    
    open var imageViewStartingFrame = CGRect.zero {
        didSet {
            coverImageView.frame = imageViewStartingFrame
        }
    }
    
    open var titleLabelStartingFrame = CGRect.zero {
        didSet {
            titleLabel.frame = titleLabelStartingFrame
        }
    }
    
    open var descLabelStartingFrame = CGRect.zero {
        didSet {
            descriptionLabel.frame = descLabelStartingFrame
        }
    }
    
    open var bottomShareViewFrame = CGRect.zero {
        didSet {
            bottomShareView.frame = bottomShareViewFrame
        }
    }
    
    open var duration = 0.5
    
    open var transitionMode: CardTransitionMode = .present
    
    open var cardColor: UIColor = .green
    
    open fileprivate(set) var cardView = UIView()
    open fileprivate(set) var coverImageView = UIImageView()
    open fileprivate(set) var titleLabel = UILabel()
    open fileprivate(set) var descriptionLabel = UILabel()
    open fileprivate(set) var bottomShareView = UIView()

    @objc public enum CardTransitionMode: Int {
        case present, dismiss
    }
}

extension AppStoreCardTransition: UIViewControllerAnimatedTransitioning {
    
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
            
            cardView = UIView()
            cardView.frame = self.startingFrame
            cardView.backgroundColor = cardColor
            
            coverImageView = UIImageView()
            coverImageView.frame = self.imageViewStartingFrame
            coverImageView.backgroundColor = .red
            cardView.addSubview(coverImageView)
            
            descriptionLabel = UILabel()
            descriptionLabel.frame = self.descLabelStartingFrame
            descriptionLabel.backgroundColor = .blue
            cardView.addSubview(descriptionLabel)
            
            bottomShareView = UIView()
            bottomShareView.frame = self.bottomShareViewFrame
            bottomShareView.backgroundColor = .yellow
            cardView.addSubview(bottomShareView)

            containerView.addSubview(cardView)
            
            containerView.backgroundColor = .clear
            presentedControllerView.alpha = 0
            containerView.addSubview(presentedControllerView)
            
            if #available(iOS 10.0, *) {
                let animator = UIViewPropertyAnimator(duration: 0.7, dampingRatio: 0.7) {
                    self.cardView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    self.cardView.layer.cornerRadius = 0
                    
                    self.coverImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width/2)
                    self.coverImageView.layer.cornerRadius = 0
                    
                    self.bottomShareView.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - self.bottomShareView.frame.size.height, width: UIScreen.main.bounds.size.width, height: self.bottomShareView.frame.size.height)
                    self.bottomShareView.layer.cornerRadius = 0
                    
                    self.descriptionLabel.frame = CGRect(x: 0, y: self.bottomShareView.frame.origin.y - 80, width: UIScreen.main.bounds.size.width, height: 80)
                    self.descriptionLabel.layer.cornerRadius = 0
                }
                animator.startAnimation()
                
                UIView.animate(withDuration: 0.0, delay: 0.7, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.1, options: .layoutSubviews, animations: {
                    presentedControllerView.alpha = 1
                }) { (isCompleted) in
                    transitionContext.completeTransition(true)                    
                    fromViewController?.endAppearanceTransition()
                    toViewController?.endAppearanceTransition()
                }
                
            } else {
                // Fallback on earlier versions
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .layoutSubviews, animations: {
                    self.cardView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    self.cardView.layer.cornerRadius = 0
                    
                    self.coverImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width/2)
                    self.coverImageView.layer.cornerRadius = 0
                    
                    self.bottomShareView.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - self.bottomShareView.frame.size.height, width: UIScreen.main.bounds.size.width, height: self.bottomShareView.frame.size.height)
                    self.bottomShareView.layer.cornerRadius = 0
                    
                    //self.descriptionLabel.sizeToFit()
                    
                    self.descriptionLabel.frame = CGRect(x: 0, y: self.bottomShareView.frame.origin.y - 80, width: UIScreen.main.bounds.size.width, height: 80)
                    self.descriptionLabel.layer.cornerRadius = 0
                }){ (isCompleted) in
                    presentedControllerView.alpha = 1
                }
            }
        } else {
            
            let returningControllerView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
            
            returningControllerView.alpha = 0.05
            
            containerView.insertSubview(returningControllerView, belowSubview: returningControllerView)
            containerView.insertSubview(self.cardView, belowSubview: returningControllerView)

            if #available(iOS 10.0, *) {
                let animator = UIViewPropertyAnimator(duration: 0.7, dampingRatio: 0.7) {
                    
                    self.coverImageView.frame = self.imageViewStartingFrame
                    self.coverImageView.layer.cornerRadius = 0
                    
                    self.cardView.frame = self.startingFrame
                    self.cardView.layer.cornerRadius = 4.0
                    
                    self.bottomShareView.frame = self.bottomShareViewFrame
                    self.bottomShareView.layer.cornerRadius = 0
                    
                    self.descriptionLabel.frame = self.descLabelStartingFrame
                    self.descriptionLabel.layer.cornerRadius = 0
                }
                animator.startAnimation()
                
                UIView.animate(withDuration: 0.0, delay: 0.7, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.1, options: .layoutSubviews, animations: {
                    returningControllerView.alpha = 0
                }) { (isCompleted) in
                    returningControllerView.removeFromSuperview()
                    self.cardView.removeFromSuperview()
                    self.coverImageView.removeFromSuperview()
                    self.bottomShareView.removeFromSuperview()
                    self.descriptionLabel.removeFromSuperview()
                    transitionContext.completeTransition(true)
                    fromViewController?.endAppearanceTransition()
                    toViewController?.endAppearanceTransition()
                }
                
            } else {
                // Fallback on earlier versions
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .layoutSubviews, animations: {
                    self.cardView.frame = self.startingFrame
                    self.cardView.layer.cornerRadius = 4.0
                    
                    self.coverImageView.frame = self.imageViewStartingFrame
                    self.coverImageView.layer.cornerRadius = 0
                    
                    self.bottomShareView.frame = self.bottomShareViewFrame
                    self.bottomShareView.layer.cornerRadius = 0
                    
                    self.descriptionLabel.frame = self.descLabelStartingFrame
                    self.descriptionLabel.layer.cornerRadius = 0
                }){ (isCompleted) in
                    returningControllerView.alpha = 0
                    returningControllerView.removeFromSuperview()
                    self.cardView.removeFromSuperview()
                    self.coverImageView.removeFromSuperview()
                    self.bottomShareView.removeFromSuperview()
                    self.descriptionLabel.removeFromSuperview()
                    transitionContext.completeTransition(true)
                    fromViewController?.endAppearanceTransition()
                    toViewController?.endAppearanceTransition()
                }
            }
            
            /*
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
            */
        }
    }
}
