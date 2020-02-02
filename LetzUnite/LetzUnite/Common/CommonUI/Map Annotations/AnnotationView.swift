//
//  AnnotationView.swift
//  LetzUnite
//
//  Created by B0081006 on 7/6/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit
import MapKit

private let kMapPinImage = UIImage(named: "bloodBankPin")!
private let kMapAnimationTime = 0.300

class AnnotationView: MKAnnotationView {

    weak var customCalloutViewDelegate: MapCalloutViewDelegate?
    weak var customCalloutView: MapCalloutView?
    override var annotation: MKAnnotation? {
        willSet { customCalloutView?.removeFromSuperview() }
    }

    convenience init(annotation: MKAnnotation?, reuseIdentifier: String?, imageName: String?) {
        self.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.image = UIImage.init(named: imageName ?? "bloodBankPin")
        //self.customCalloutView?.title.text = (annotation as! AnnotationInfo).title
        //self.customCalloutView?.subtitle.text = (annotation as! AnnotationInfo).locationName
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = false
        //self.image = kMapPinImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false
        //self.image = kMapPinImage
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected { // 2
            self.customCalloutView?.removeFromSuperview() // remove old custom callout (if any)
            
            if let newCustomCalloutView = loadCalloutView() {
                
                // fix location from top-left to its right place.
                newCustomCalloutView.frame.origin.x -= newCustomCalloutView.frame.width / 2.0 - (self.frame.width / 2.0)
                newCustomCalloutView.frame.origin.y -= newCustomCalloutView.frame.height
                
                // set custom callout view
                self.addSubview(newCustomCalloutView)
                self.customCalloutView = newCustomCalloutView
                
                // animate presentation
                if animated {
                    self.customCalloutView!.alpha = 0.0
                    UIView.animate(withDuration: 0.5, animations: {
                        self.customCalloutView!.alpha = 1.0
                    })
                }
            }
        } else { // 3
            if customCalloutView != nil {
                if animated { // fade out animation, then remove it.
                    UIView.animate(withDuration: 0.5, animations: {
                        self.customCalloutView!.alpha = 0.0
                    }, completion: { (success) in
                        self.customCalloutView!.removeFromSuperview()
                    })
                } else { self.customCalloutView!.removeFromSuperview() } // just remove it.
            }
        }
    }
    
    func loadCalloutView() -> MapCalloutView? {
        if let views = Bundle.main.loadNibNamed("MapCalloutView", owner: self, options: nil) as? [MapCalloutView], views.count > 0 {
            let calloutMapView = views.first!
            calloutMapView.delegate = self.customCalloutViewDelegate
            if let calloutAnnotation = annotation as? AnnotationInfo {
                //let item = calloutAnnotation.mapItem()
                calloutMapView.configureMapCalloutView(data: calloutAnnotation)
            }
            return calloutMapView
        }
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.customCalloutView?.removeFromSuperview()
    }
    
    // MARK: - Detecting and reaction to taps on custom callout.
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // if super passed hit test, return the result
        if let parentHitView = super.hitTest(point, with: event) { return parentHitView }
        else { // test in our custom callout.
            if customCalloutView != nil {
                return customCalloutView!.hitTest(convert(point, to: customCalloutView!), with: event)
            } else { return nil }
        }
    }
}
