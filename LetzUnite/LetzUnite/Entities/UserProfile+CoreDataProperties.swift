//
//  UserProfile+CoreDataProperties.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import CoreData


extension UserProfile {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProfile> {
        return NSFetchRequest<UserProfile>(entityName: "Profile");
    }
    
    @NSManaged public var weight: Int16
    @NSManaged public var username: String?
    @NSManaged public var securityQues: String?
    @NSManaged public var securityAns: String?
    @NSManaged public var role: String?
    @NSManaged public var password: String?
    @NSManaged public var mobile: String?
    @NSManaged public var lastname: String?
    @NSManaged public var height: Int16
    @NSManaged public var gender: String?
    @NSManaged public var firstname: String?
    @NSManaged public var email: String?
    @NSManaged public var dob: Date?
    @NSManaged public var country: Int32
    @NSManaged public var id: Int32
    
}
