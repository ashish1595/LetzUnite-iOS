//
//  ChatTableCell.swift
//  LetzUnite
//
//  Created by B0081006 on 7/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

class ChatTableCell: UITableViewCell {
    
    @IBOutlet var viewMessage:UIView!
    @IBOutlet var labelMessage:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.labelMessage?.numberOfLines = 0
        self.labelMessage?.lineBreakMode = .byWordWrapping
        
        self.viewMessage?.layer.cornerRadius = 5
        self.viewMessage?.clipsToBounds = true
        self.viewMessage?.layer.masksToBounds = true

        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setMessage(_ message:Message) {
        self.labelMessage?.text = message.content
    }
}
