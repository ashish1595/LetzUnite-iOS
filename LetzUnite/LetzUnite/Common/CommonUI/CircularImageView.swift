//
//  CircularImageView.swift
//  LetzUnite
//
//  Created by Himanshu on 5/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = frame.size.width/2.0
        self.layer.masksToBounds = true
    }
}
