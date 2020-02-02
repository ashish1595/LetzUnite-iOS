//
//  UserProfileModel.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON

struct UserProfileModel {
    private struct SerializationKeys {
        static let id = "id"
        static let email = "email"
        static let username = "username"
        static let mobile = "mobile"
        static let password = "password"
        
        static let confirmPassword = "confirm_password"

        static let firstName = "first_name"
        static let lastName = "last_name"
        static let dateOfBirth = "date_of_birth"
        static let gender = "gender"
        static let height = "height"
        static let weight = "weight"
        static let country = "country"
    }

    var firstname: String?
    var lastname: String?
    var username: String?
    var email: String?
    var mobile: String?
    var password: String?
    var confirmPassword: String?

    var dob :String?
    var gender: String?
    var height: String?
    var weight: String?
    var id: Int?
    var country: String?
}

//Registration API
struct UserProfileResponse {
    private struct SerializationKeys {
        static let data = "data"
        static let message = "message"
        static let email = "email"
    }
    
    let data: Bool?
    let message: String?
    var email: String?
}

extension UserProfileResponse {
    init(json:JSON) throws{
        guard let data = json[SerializationKeys.data].bool else {
            throw Serialization.missing(SerializationKeys.data)
        }
        
        guard let message = json[SerializationKeys.message].string else {
            throw Serialization.missing(SerializationKeys.message)
        }
        
        self.message = message
        self.data = data
    }
}

//Profile Update API
struct UserUpdateProfileResponse {
    private struct SerializationKeys {
        static let data = "data"
        static let message = "message"
        static let status = "status"
    }
    
    let status: Int?
    let data: String?
    let message: String?
}

extension UserUpdateProfileResponse {
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


