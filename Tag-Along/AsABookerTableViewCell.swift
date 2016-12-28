//
//  AsABookerTableViewCell.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/20/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class AsABookerTableViewCell: UITableViewCell {
    @IBOutlet weak var btn_email: UIButton!

    @IBOutlet weak var btn_rating: UIButton!
    @IBOutlet weak var btn_message: UIButton!
    @IBOutlet weak var btn_phone: UIButton!
    @IBOutlet weak var img_view_profile: UIImageView!
   
    @IBOutlet weak var lbl_driver_name: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    
    @IBOutlet weak var lbl_time: UILabel!
    
    @IBOutlet weak var lbl_price: UILabel!
    
    @IBOutlet weak var lbl_state: UILabel!
    
    @IBOutlet weak var lbl_payment_status: UILabel!
    
    @IBOutlet weak var lbl_destination: UILabel!
    @IBOutlet weak var lbl_departure_from: UILabel!
       
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img_view_profile.layer.borderWidth = 1
        img_view_profile.layer.masksToBounds = false
        img_view_profile.layer.borderColor = UIColor.clear.cgColor
        img_view_profile.layer.cornerRadius = img_view_profile.frame.height/2
        
        img_view_profile.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
