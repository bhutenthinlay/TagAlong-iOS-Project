//
//  IndividualRidesTableViewCell.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/12/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import AwesomeButton
import STRatingControl
class IndividualRidesTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_destination: UILabel!
    @IBOutlet weak var lbl_departure_from: UILabel!
    @IBOutlet weak var btn_price: AwesomeButton!
    @IBOutlet weak var lbl_driver_name: UILabel!
    @IBOutlet weak var img_view_driver: UIImageView!
    @IBOutlet weak var ratingStar: STRatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img_view_driver.layer.borderWidth = 1
        img_view_driver.layer.masksToBounds = false
        img_view_driver.layer.borderColor = UIColor.clear.cgColor
       img_view_driver.layer.cornerRadius = img_view_driver.frame.height/2
        
       img_view_driver.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
