//
//  Message.swift
//  LetzUnite
//
//  Created by B0081006 on 7/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

class Message: NSObject {
    var content:String
    var isOutgoing:Bool

     init(content:String, isOutgoing:Bool) {
        self.content = content
        self.isOutgoing = isOutgoing
        super.init()
    }
}
