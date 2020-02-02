//
//  RewardsModel.swift
//  LetzUnite
//
//  Created by Himanshu on 5/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON

struct RewardResponse {
    private struct SerializationKeys {
        static let status = "status"
        static let message = "message"
        static let data = "data"

    }
    
    let status: Int?
    let message: String?
    let data: Array<Any>?
}

extension RewardResponse {
    init(json:JSON) throws{
        guard let status = json[SerializationKeys.status].int else {
            throw Serialization.missing(SerializationKeys.status)
        }
        
        self.status = status
        self.message = json[SerializationKeys.message].string ?? ""
        
        if self.status != 200 {
            throw Serialization.businessCase(self.status!, self.message!, nil)
        }
        
        self.data = json[SerializationKeys.data].array ?? []
    }
}
