//
//  NavigationBarView.swift
//  LetzUnite
//
//  Created by Himanshu on 5/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

enum NavigationType {
    case kFeedsNav
    case kSearchNav
    case kDetailNav
}

@objc protocol NavigationBarProtocol: class {
    @objc optional func didPressNotificationBellButton()
    @objc optional func didPressBackButton()
}

class NavigationBarView: UIView {

    weak var delegate:NavigationBarProtocol?
    
    @IBOutlet var customView: UIView!
    
    @IBOutlet var view_detailNav: UIView!
    @IBOutlet var label_detailTitle: UILabel!
    @IBOutlet var buttonBack: UIButton!

    @IBOutlet var view_feedsNav: UIView!
    @IBOutlet var label_feedsTitle: UILabel!
    @IBOutlet var buttonNotificationBell: UIButton!
    
    @IBOutlet var view_searchNav: UIView!
    @IBOutlet var label_searchTitle: UILabel!
    @IBOutlet var button_searchNav_first_from_Right: UIButton!
    
    convenience init(navType navigationType: NavigationType, frame: CGRect) {
        self.init(frame: frame)
        
        switch navigationType {
        case .kFeedsNav:
            view_feedsNav.frame = CGRect(x: frame.origin.x, y: 0, width: frame.size.width, height: frame.size.height)
            customView.addSubview(view_feedsNav)
        case .kSearchNav:
            view_searchNav.frame = CGRect(x: frame.origin.x, y: 0, width: frame.size.width, height: frame.size.height)
            customView.addSubview(view_searchNav)
        default:
            view_detailNav.frame = CGRect(x: frame.origin.x, y: 0, width: frame.size.width, height: frame.size.height)
            customView.addSubview(view_detailNav)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureXIB()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureXIB()
    }
  
    func configureXIB() {
        customView = configureNib()
        customView.frame = bounds
        addSubview(customView)
    }
    
    func configureNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NavigationBarView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    @IBAction func actionBackButton(_ sender: Any) {
        delegate?.didPressBackButton!()
    }
    
    @IBAction func actionNotificationBellButton(_ sender: Any) {
        delegate?.didPressNotificationBellButton!()
    }
    
    @IBAction func actionSearchNavFirstButtonFromRight(_ sender: Any) {
        delegate?.didPressNotificationBellButton!()
    }
    
}
