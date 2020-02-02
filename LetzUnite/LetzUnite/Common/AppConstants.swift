//
//  AppConstants.swift
//  Himanshu
//
//  Created by Himanshu on 3/31/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

let appName = "LetzUnite"








//MARK: Validation Constants
let registration_fullname_max_length = 50
let registration_mobile_num_equals = 10
let registration_email_max_length = 50
let registration_password_max_length = 50



//MARK: UserDefault Serialization Keys
enum UserDefaultsSerializationKey: String {
    case profile = "lu_userProfile"
    case deviceId = "lu_deviceId"
    case userId = "lu_userId"
    case userName = "lu_userName"
    case isLogined = "lu_isUserLogined"
}

//Search User Types
enum SearchUserTypes: Int {
    case all
    case donors
    case requesters
    case bloodBanks
}

enum BloodGroupTypes: String {
    case all = "All"
    case o_negative = "O-"
    case o_positive = "O+"
    case a_negative = "A-"
    case a_positive = "A+"
    case b_negative = "B-"
    case b_positive = "B+"
    case ab_negative = "AB-"
    case ab_positive = "AB+"
}

