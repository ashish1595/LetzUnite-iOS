//
//  AppAlert.swift
//  LetzUnite
//
//  Created by B0081006 on 5/31/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

@objc protocol AppAlertProtocol: class {
    @objc optional func didPressButtonWith(title:String? ,clickedIndex:String?)
}

class AppAlert: NSObject {
    
    static weak var delegate:AppAlertProtocol?
    
    class func showMessage(message: String) -> Void {
        let alert = UIAlertController(title: appName, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
    }
    
    class func showAlertWith(message: String?, buttonTitles:[String], delegate:UIViewController) -> Void {
        
        self.delegate = delegate as? AppAlertProtocol
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        for item in buttonTitles {
            let buttonAction: UIAlertAction = UIAlertAction(title: item, style: .default) { action -> Void in
                if self.delegate != nil {
                    if let itemTitle = action.title {
                        if let index = buttonTitles.index(of: itemTitle) {
                            self.delegate?.didPressButtonWith!(title: itemTitle, clickedIndex: "\(index)")
                        }
                    }
                }
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(buttonAction)
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
    }
}


extension AppAlert: UIAlertViewDelegate {
    
    
}
