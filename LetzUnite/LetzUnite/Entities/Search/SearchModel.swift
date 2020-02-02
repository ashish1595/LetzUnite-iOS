//
//  SearchModel.swift
//  LetzUnite
//
//  Created by Himanshu on 5/16/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON
import MapKit

struct SearchRequestModel {
    private struct SerializationKeys {
        static let id = "id"
        static let searchUserType = "searchUserType"
        static let location = "location"
        static let bloodGroup = "bloodGroup"
        static let range = "range"
    }
    
    var searchUserType:String? = ""
    var location:String? = ""
    var bloodGroup:String? = ""
    var range:String? = ""
}

struct SearchResponse {
    private struct SerializationKeys {
        static let status = "status"
        static let data = "data"
        static let message = "message"
    }
    
    let status: Int?
    let message: String?
    let searchedRecords: Array<AnnotationInfo>?
}

extension SearchResponse {
    init(json:JSON) throws{
        
        guard let status = json[SerializationKeys.status].int else {
            throw Serialization.missing(SerializationKeys.status)
        }
        
        self.status = status
        self.message = json[SerializationKeys.message].string ?? ""
        
        if self.status != 200 {
            throw Serialization.businessCase(self.status!, self.message!, nil)
        }
                
        if let array = json[SerializationKeys.data].array {
            var annotationArray = Array<AnnotationInfo>()
            for item in array {
                if let arrayLocation = item["locations"].array, arrayLocation.count == 2 {
                    let annotation = AnnotationInfo.init(
                        title: item["name"].string ?? "...",
                        locationName: item["address"].string ?? "...",
                        type: item["type"].string ?? "",
                        coordinate: CLLocationCoordinate2DMake(arrayLocation[0].number as? CLLocationDegrees ?? 0,arrayLocation[1].number as? CLLocationDegrees ?? 0), imageUrl: item["imageUrl"].string ?? "", userId: item["id"].string ?? "")
                    annotationArray.append(annotation)
                }
            }
            self.searchedRecords = annotationArray
        }else {
            self.searchedRecords = []
        }
    }
}
