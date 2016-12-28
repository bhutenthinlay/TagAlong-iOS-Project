//
//  StopOverTableViewCell.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/13/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class StopOverTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_stopover: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
