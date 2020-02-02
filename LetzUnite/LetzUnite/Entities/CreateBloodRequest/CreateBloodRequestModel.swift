//
//  CreateBloodRequestModel.swift
//  LetzUnite
//
//  Created by Himanshu on 5/13/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON

struct BloodRequestModel {
    var availableHours:String?
    var bloodType:String?
    var city:String?
    var contactPersonNumber:String?
    var disease:String?
    var hospitalContactPerson:String?
    var hospitalName:String?
    var latitude:String?
    var longitude:String?
    var location: String?
    var patientName:String?
    var state:String?
}


struct BloodRequestResponse {
    private struct SerializationKeys {
        static let status = "status"
        static let data = "data"
        static let message = "message"
    }
    
    let status: Int?
    var data: String?
    let message: String?
}

extension BloodRequestResponse {
    init(json:JSON) throws{
        
        guard let status = json[SerializationKeys.status].int else {
            throw Serialization.missing(SerializationKeys.status)
        }
        
        self.status = status
        self.message = json[SerializationKeys.message].string ?? ""

        if self.status != 200 {
            throw Serialization.businessCase(self.status!, self.message!, nil)
        }
        
        self.data = json[SerializationKeys.data].string ?? ""
    }
}
