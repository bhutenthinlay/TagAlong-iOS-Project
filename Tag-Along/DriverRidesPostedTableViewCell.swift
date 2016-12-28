//
//  DriverRidesPostedTableViewCell.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/9/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class DriverRidesPostedTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_price_per_seat: UILabel!
    @IBOutlet weak var lbl_number_of_seats: UILabel!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_to_location: UILabel!
    @IBOutlet weak var lbl_from_location: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
