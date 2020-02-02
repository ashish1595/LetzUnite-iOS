//
//  AppToast.swift
//  Carpool
//
//  Created by B0081006 on 5/31/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit
import KSToastView

class AppToast: NSObject {
    class func showToast(with message:String?, delay:TimeInterval) {
        KSToastView.ks_showToast(message, delay: delay)
    }
    
    class func showToast(with message:String?) {
        KSToastView.ks_showToast(message)
    }
}
