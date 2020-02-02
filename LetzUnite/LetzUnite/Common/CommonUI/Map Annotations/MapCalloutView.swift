//
//  MapCalloutView.swift
//  LetzUnite
//
//  Created by B0081006 on 7/7/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

protocol MapCalloutViewDelegate: class { // 1
    func detailsRequestedForCallout(callout: Any)
}

class MapCalloutView: UIView {

    weak var delegate: MapCalloutViewDelegate?
    @IBOutlet var backgroundContentButton: UIButton!
    @IBOutlet var navigationButton: UIButton!
    @IBOutlet var title: UILabel!
    @IBOutlet var subtitle: UILabel!
    @IBOutlet var imageVw: UIImageView!
    
    var mapAnnotationData:Any = Dictionary<String,String>()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundContentButton.layer.cornerRadius = 8.0
    backgroundContentButton.applyArrowDialogAppearanceWithOrientation(arrowOrientation: .down)
    }
    
    @IBAction func navigateToLocation(_ sender: Any) {
        delegate?.detailsRequestedForCallout(callout: mapAnnotationData)
    }
    
    func configureMapCalloutView(data: Any) {
        //show data on annotation view
        let annotation = data as! AnnotationInfo
        self.title.text = annotation.title
        self.subtitle.text = annotation.locationName
    }

    // MARK: - Hit test. We need to override this to detect hits in our custom callout.
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // Check if it hit our annotation detail view components.
        
        // details button
        if let result = navigationButton.hitTest(convert(point, to: navigationButton), with: event) {
            return result
        }
        
        return backgroundContentButton.hitTest(convert(point, to: backgroundContentButton), with: event)
    }
}
