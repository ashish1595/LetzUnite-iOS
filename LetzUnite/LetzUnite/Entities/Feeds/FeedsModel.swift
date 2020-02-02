//
//  FeedsModel.swift
//  LetzUnite
//
//  Created by Himanshu on 5/12/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FeedsResponse {
    private struct SerializationKeys {
        static let status = "status"
        static let data = "data"
        static let message = "message"
    }
    
    let status: Int?
    let message: String?
    var arrayFeeds: Array<FeedsModel?>
}

extension FeedsResponse {
    init(json:JSON) throws{
        
        arrayFeeds = Array()

        guard let status = json[SerializationKeys.status].int else {
            throw Serialization.missing(SerializationKeys.status)
        }
        
        self.status = status
        self.message = json[SerializationKeys.message].string ?? ""
        
        if self.status != 200 {
            throw Serialization.businessCase(self.status!, self.message!, nil)
        }
        
        if let items = json[SerializationKeys.data].array {
            for item in items {
                if let feedModel = FeedsModel(json: item) {
                    arrayFeeds.append(feedModel)
                }
            }
        }
    }
}


struct BloodRequestsModel {
    private struct SerializationKeys {
        static let data = "data"
        static let state = "state"
        static let disease = "disease"
        static let contactPersonNumber = "contactPersonNumber"
        static let longitude = "longitude"
        static let latitude = "latitude"
        static let hospitalName = "hospitalName"
        static let bloodType = "bloodType"
        static let bloodUnit = "bloodUnit"
        static let patientName = "patientName"
        static let location = "location"
        static let city = "city"
        static let availableHours = "availableHours"
        static let hospitalContactPerson = "hospitalContactPerson"
        static let createdDate = "createdDate"
        static let userId = "userId"
        static let notificationTypeId = "notificationTypeId"
        static let readFlag = "readFlag"
    }
    
     let notificationTypeId : Int?
     let readFlag : Bool?
     let state : String?
     let disease : String?
     let contactPersonNumber : String?
     let longitude : Float?
     let latitude : Float?
     let hospitalName : String?
     let bloodType : String?
     let bloodUnit : String?
     let patientName : String?
     let location : String?
     let city : String?
     let availableHours : String?
     let hospitalContactPerson : String?
     let createdDate : String?
     let userId : String?
}

extension BloodRequestsModel {
    init?(json:JSON) {
        notificationTypeId = json[SerializationKeys.notificationTypeId].int
        readFlag = json[SerializationKeys.readFlag].bool
        state = json[SerializationKeys.data][SerializationKeys.state].string ?? ""
        disease = json[SerializationKeys.data][SerializationKeys.disease].string ?? ""
        contactPersonNumber = json[SerializationKeys.data][SerializationKeys.contactPersonNumber].string ?? ""
        if let array = json[SerializationKeys.data][SerializationKeys.location].arrayObject, array.count == 2  {
            latitude = array[0] as? Float ?? 0
            longitude = array[1] as? Float ?? 0
        }else {
            latitude =  0
            longitude =  0
        }
        hospitalName = json[SerializationKeys.data][SerializationKeys.hospitalName].string ?? ""
        bloodType = json[SerializationKeys.data][SerializationKeys.bloodType].string ?? ""
        bloodUnit = json[SerializationKeys.data][SerializationKeys.bloodUnit].string ?? "2"
        patientName = json[SerializationKeys.data][SerializationKeys.patientName].string ?? ""
        location = json[SerializationKeys.data][SerializationKeys.location].string ?? ""
        city = json[SerializationKeys.data][SerializationKeys.city].string ?? ""
        availableHours = json[SerializationKeys.data][SerializationKeys.availableHours].string ?? ""
        hospitalContactPerson = json[SerializationKeys.data][SerializationKeys.hospitalContactPerson].string ?? ""
        createdDate = json[SerializationKeys.createdDate].string ?? ""
        userId = json[SerializationKeys.userId].string ?? ""
    }
}

struct QuotesModel {
    private struct SerializationKeys {
        static let data = "data"
        static let description = "description"
        static let createdDate = "createdDate"
        static let userId = "userId"
        static let notificationTypeId = "notificationTypeId"
        static let readFlag = "readFlag"
        static let imageUrl = "imageUrl"
    }
    
    let description : String?
    let createdDate : String?
    let userId : String?
    let notificationTypeId : Int?
    let readFlag : Bool?
    let imageUrl : URL?
}

extension QuotesModel {
    init(json:JSON) {
        description = json[SerializationKeys.data][SerializationKeys.description].string ?? ""
        createdDate = json[SerializationKeys.createdDate].string ?? ""
        userId = json[SerializationKeys.userId].string ?? ""
        notificationTypeId = json[SerializationKeys.notificationTypeId].int
        readFlag = json[SerializationKeys.readFlag].bool
        if let strUrl = json[SerializationKeys.data][SerializationKeys.imageUrl].string {
            imageUrl = URL(string: strUrl)
        }else {
            imageUrl = nil
        }
    }
}


struct FeedsModel {
    private struct SerializationKeys {
        static let notificationTypeId = "notificationTypeId"
        static let notificationDetail = "notificationDetail"
        static let notificationDetailList = "notificationDetailList"
    }
    
    let notificationTypeId : Int?
    let notificationDetail : Any?
    let notificationDetailList : Array<Any>?
}

extension FeedsModel {
    init?(json:JSON) {
        self.notificationTypeId = json[SerializationKeys.notificationTypeId].int
        
        if self.notificationTypeId == 1 {
            self.notificationDetail = nil
            self.notificationDetailList = Array<BloodRequestsModel>()
            if let items = json[SerializationKeys.notificationDetailList].array {
                for item in items {
                    if let bloodReqModel = BloodRequestsModel(json: item) {
                        self.notificationDetailList?.append(bloodReqModel)
                    }
                }
            }
        }else if self.notificationTypeId == 3{
            self.notificationDetail = QuotesModel(json: json)
            self.notificationDetailList = nil
        }else {
            self.notificationDetail = nil
            self.notificationDetailList = nil
        }
        
    }
}
