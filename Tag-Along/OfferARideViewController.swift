
//
//  OfferARideViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/8/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import AwesomeButton
class OfferARideViewController: UIViewController {
    weak var delegate: SegueHandler?
   
    @IBAction func btn_round_way(_ sender: AwesomeButton) {
       // delegate?.segueToNext(identifier: "twoway", defaultValue: 5)
        performSegue(withIdentifier: "twoway", sender: self)
    }
    @IBAction func btn_one_way(_ sender: AwesomeButton) {
        //delegate?.segueToNext(identifier: "oneway", defaultValue: 6)
        performSegue(withIdentifier: "oneway", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
