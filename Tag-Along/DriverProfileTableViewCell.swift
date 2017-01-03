//
//  DriverProfileTableViewCell.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/8/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import STRatingControl
class DriverProfileTableViewCell: UITableViewCell {
    var ratingValue: Int!
    @IBOutlet weak var rating: STRatingControl!
    @IBOutlet weak var img_view_profile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
                 // rating.rating = ratingValue
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
