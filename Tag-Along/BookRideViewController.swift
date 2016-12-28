//
//  BookRideViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/13/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import AwesomeButton
class BookRideViewController: UIViewController {
    var imageURL: String!
    
    @IBOutlet weak var btn_price_per_seat: AwesomeButton!
    @IBOutlet weak var btn_proceed_to_checkout: UIButton!
    @IBOutlet weak var img_view_profile: UIImageView!
    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
    }
    @IBAction func btn_add(_ sender: AwesomeButton) {
        var numberOfSeats = Int(txt_field_no_of_seats.text!)
        numberOfSeats = numberOfSeats! + 1
        txt_field_no_of_seats.text = "\(numberOfSeats!)"
    }
    @IBAction func btn_subtract(_ sender: AwesomeButton) {
        var numberOfSeats = Int(txt_field_no_of_seats.text!)
        if numberOfSeats! <= 1
        {
         print("cannot be less than one")
        }
        else{
        numberOfSeats = numberOfSeats! - 1
        txt_field_no_of_seats.text = "\(numberOfSeats!)"
        }
    }
    
    @IBOutlet weak var txt_field_no_of_seats: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProfileImage()
        btn_proceed_to_checkout.titleLabel?.numberOfLines = 1
        btn_proceed_to_checkout.titleLabel?.adjustsFontSizeToFitWidth = true
        btn_price_per_seat.titleLabel?.numberOfLines = 1
        btn_price_per_seat.titleLabel?.adjustsFontSizeToFitWidth = true
        
      
        
    }
    func setUpProfileImage()
    {
        img_view_profile.layer.borderWidth = 1
        img_view_profile.layer.masksToBounds = false
        img_view_profile.layer.borderColor = UIColor.clear.cgColor
        img_view_profile.layer.cornerRadius = img_view_profile.frame.height/2
        
        img_view_profile.clipsToBounds = true
        img_view_profile.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading-icon-1"), options: [.progressiveDownload, .continueInBackground])
    }

}
