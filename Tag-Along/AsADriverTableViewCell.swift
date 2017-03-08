//
//  AsADriverTableViewCell.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/14/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class AsADriverTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_number_of_seats: UILabel!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var img_view_ride_type: UIImageView!
    @IBOutlet weak var lbl_departure_from: UILabel!
    
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_destination: UILabel!
   
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
