//
//  Place.swift
//  LetzUnite
//
//  Created by B0081006 on 8/4/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

private struct AllKeys {
    static let placeId = "place_id"
    static let mainText = "main_text"
    static let secondaryText = "secondary_text"
    static let formatting = "structured_formatting"
}

class Place: NSObject {
    open let id: String
    open let address1: String
    open let address2: String
    
    override open var description: String {
        get { return "\(address1), \(address2)" }
    }
    
    init(id: String, address1: String, address2: String) {
        self.id = id
        self.address1 = address1
        self.address2 = address2
    }
    
    convenience init(dict: [String: Any]) {
        let formatting = dict[AllKeys.formatting] as? [String: Any]
        
        self.init(
            id: dict[AllKeys.placeId] as? String ?? "",
            address1: formatting?[AllKeys.mainText] as? String ?? "",
            address2: formatting?[AllKeys.secondaryText] as? String ?? ""
        )
    }
}
