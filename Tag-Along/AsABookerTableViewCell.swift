//
//  AsABookerTableViewCell.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/20/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class AsABookerTableViewCell: UITableViewCell {
   
    @IBOutlet weak var img_view_ride_type: UIImageView!
    @IBOutlet weak var lbl_date: UILabel!
    
    @IBOutlet weak var lbl_time: UILabel!
    
    @IBOutlet weak var lbl_price: UILabel!
    
    
    @IBOutlet weak var lbl_destination: UILabel!
    @IBOutlet weak var lbl_departure_from: UILabel!
       
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_view_profile_pic: UIImageView!
   
    @IBOutlet weak var btn_rate: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img_view_profile_pic.layer.borderWidth = 1.0
        img_view_profile_pic.layer.masksToBounds = false
        img_view_profile_pic.layer.borderColor = UIColor.white.cgColor
        img_view_profile_pic.layer.cornerRadius = img_view_profile_pic.frame.size.width/2
        img_view_profile_pic.clipsToBounds = true

         }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
