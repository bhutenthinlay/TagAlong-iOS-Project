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
    var tag: Int!
    var rideDetail = RidesDetails()
    var actualPriceToCarry: Double!
    var actualPrice: Int!
    var actualPricePoints: Int!
    
    @IBAction func bar_btn_message(_ sender: UIBarButtonItem) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatListViewController") as? ChatListViewController {
            //            viewController.newsObj = newsObj
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    @IBOutlet weak var btn_price: UIButton!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_destination_to: UILabel!
    @IBOutlet weak var lbl_departure_from: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_booking_no: UILabel!
    @IBOutlet weak var btn_price_per_seat: AwesomeButton!
    @IBOutlet weak var btn_proceed_to_checkout: UIButton!
    @IBOutlet weak var img_view_profile: UIImageView!
    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
    }
    @IBAction func btn_add(_ sender: AwesomeButton) {
        var numberOfSeats = Int(txt_field_no_of_seats.text!)
        if numberOfSeats! < count!{
        numberOfSeats = numberOfSeats! + 1
        txt_field_no_of_seats.text = "\(numberOfSeats!)"
            btn_price.setTitle("$ \(price * Double(numberOfSeats!))", for: .normal)
            actualPriceToCarry = price * Double(numberOfSeats!)
            
        }
        else{
          alert(alert: "Alert", message: "Only \(count!) seats are available")
        }
    }
    
    @IBAction func btn_proceed_to_checkout(_ sender: UIButton) {
        performSegue(withIdentifier: "checkout", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkout"
        {
             let dvc = segue.destination as! PaymentNewViewController
              dvc.actualAmount = actualPriceToCarry
            
        }
    }
    @IBAction func btn_subtract(_ sender: AwesomeButton) {
        var numberOfSeats = Int(txt_field_no_of_seats.text!)
        if numberOfSeats! <= 1
        {
         alert(alert: "Alert", message: "Cannot be less than one")
        }
        else{
        numberOfSeats = numberOfSeats! - 1
        txt_field_no_of_seats.text = "\(numberOfSeats!)"
             btn_price.setTitle("$ \(price * Double(numberOfSeats!))", for: .normal)
            actualPriceToCarry = price * Double(numberOfSeats!)
        }
    }
    var count: Int!
    var price: Double!
    @IBOutlet weak var txt_field_no_of_seats: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageURL = rideDetail.driverImageURL[tag]
        setUpProfileImage()
        btn_proceed_to_checkout.titleLabel?.numberOfLines = 1
        btn_proceed_to_checkout.titleLabel?.adjustsFontSizeToFitWidth = true
        btn_price_per_seat.titleLabel?.numberOfLines = 1
        btn_price_per_seat.titleLabel?.adjustsFontSizeToFitWidth = true
        lbl_name.text = rideDetail.driverName[tag]
        lbl_date.text = rideDetail.driverDepartureDate[tag]
        lbl_time.text = rideDetail.driverDepartureTime[tag]
        lbl_departure_from.text = rideDetail.driverDepartureFrom[tag]
        lbl_destination_to.text = rideDetail.driverDestinationTo[tag]
        count = Int(rideDetail.driverSeatAvailable[tag])
        btn_price_per_seat.setTitle("\(rideDetail.driverPrice[tag]) / seat", for: .normal)
        
        price = Double(rideDetail.driverPrice[tag].replacingOccurrences(of: "$ ", with: ""))
        actualPriceToCarry = price
        print("price is \(price)")
        btn_price.setTitle(rideDetail.driverPrice[tag].replacingOccurrences(of: ".00", with: ".0"), for: .normal)
        
        
      
        
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
    //MARK: - ALERT
    func alert(alert: String, message: String)
    {
        let alert = UIAlertController(title: alert, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}
