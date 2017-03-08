//
//  ChatListTableViewCell.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 2/6/17.
//  Copyright © 2017 Tenzin Thinlay. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_last_message: UILabel!
    @IBOutlet weak var img_view_profile: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img_view_profile.layer.borderWidth = 1.0
        img_view_profile.layer.masksToBounds = false
        img_view_profile.layer.borderColor = UIColor.white.cgColor
        img_view_profile.layer.cornerRadius = img_view_profile.frame.size.width/2
        img_view_profile.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
