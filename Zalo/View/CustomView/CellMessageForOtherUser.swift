//
//  CellMessageForOtherUser.swift
//  Zalo
//
//  Created by LamHan on 6/18/18.
//  Copyright © 2018 LamHan. All rights reserved.
//

import UIKit

class CellMessageForOtherUser: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var contentTextfield: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
