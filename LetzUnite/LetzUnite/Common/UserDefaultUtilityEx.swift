//
//  UserDefaultUtilityEx.swift
//  LetzUnite
//
//  Created by Himanshu on 5/2/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    class func saveObject(object: Any, forKey key: String) {
        if let data:Data = NSKeyedArchiver.archivedData(withRootObject: object) as Data? {
            self.standard.set(data, forKey: key)
            self.standard.synchronize()
        }
        
    }
    
    class func retrieveObject(forKey key: String) -> Any? {
        if let data = self.standard.object(forKey: key) as? Data {
            if let object:AnyObject = NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject? {
                return object
            }
        }
        return nil
    }
    
}
