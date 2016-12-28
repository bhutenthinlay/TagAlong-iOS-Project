//
//  CardTableViewCell.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/16/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var btn_radio: UIButton!
    @IBOutlet weak var image_view_card: UIImageView!
    @IBOutlet weak var lbl_card_number: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // btn_radio.isSelected = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
