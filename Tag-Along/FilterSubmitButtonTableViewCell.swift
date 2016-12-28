//
//  FilterSubmitButtonTableViewCell.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/14/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import AwesomeButton

class FilterSubmitButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var btn_submit: AwesomeButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
