//
//  NewCardTableViewCell.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/19/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class NewCardTableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_actual_amount: UILabel!

    @IBOutlet weak var txt_field_card_cvv: UITextField!
    @IBOutlet weak var txt_field_card_exp_date: UITextField!
    @IBOutlet weak var txt_field_card_name: UITextField!
    @IBOutlet weak var img_view_card: UIImageView!
    @IBOutlet weak var txt_field_card_number: UITextField!
    
    @IBOutlet weak var btn_add_card: UIButton!
    @IBOutlet weak var lbl_acutal_amount_decimal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
