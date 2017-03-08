//
//  RidesDetailViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/12/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import AwesomeButton
import STRatingControl
class RidesDetailViewController: UIViewController {
    
    @IBAction func bar_btn_message(_ sender: UIBarButtonItem) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatListViewController") as? ChatListViewController {
            //            viewController.newsObj = newsObj
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var lbl_departure_from: UILabel!
    @IBOutlet weak var btn_amount: AwesomeButton!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_number_of_seats: UILabel!
    @IBOutlet weak var lbl_schedule: UILabel!
    @IBOutlet weak var lbl_detour: UILabel!
    @IBOutlet weak var lbl_luggage_size: UILabel!
    @IBOutlet weak var lbl_car_brand_name: UILabel!
    @IBOutlet weak var lbl_car_comfort: UILabel!
    @IBOutlet weak var lbl_car_type: UILabel!
    @IBOutlet weak var lbl_car_plate_number: UILabel!
    @IBOutlet weak var lbl_destination_to: UILabel!
    @IBOutlet weak var ratingStar: STRatingControl!
    @IBOutlet weak var lbl_no_smoking: UILabel!
    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
    }
   
   // @IBOutlet weak var btn_book_this_ride: AwesomeButton!
    @IBOutlet weak var btn_book_this_ride: UIButton!
  
    @IBAction func btn_book_this_ride(_ sender: UIButton) {
         performSegue(withIdentifier: "bookingseat", sender: self)
    }
    
//    @IBAction func btn_book_this_ride(_ sender: AwesomeButton) {
//        performSegue(withIdentifier: "bookingseat", sender: self)
//    }
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_view_profile: UIImageView!
    var imageURL: String!
    var tag: Int!
    var rideDetail = RidesDetails()
    @IBOutlet weak var lbl_no_pets: UILabel!
    @IBOutlet weak var view_view: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_no_pets.sizeToFit()
        lbl_no_smoking.sizeToFit()
        setUpProfileImage()
        scroll.contentSize.height = 673
        let width1 = self.view.frame.size.width
        scroll.contentSize.width = width1
        ratingStar.rating = rideDetail.driverRating[tag]
        lbl_name.text = rideDetail.driverName[tag]
        btn_amount.setTitle(rideDetail.driverPrice[tag], for: .normal)
        lbl_departure_from.text = rideDetail.driverDepartureFrom[tag]
        lbl_destination_to.text = rideDetail.driverDestinationTo[tag]
        lbl_date.text = rideDetail.driverDepartureDate[tag]
        lbl_time.text = rideDetail.driverDepartureTime[tag]
        lbl_car_brand_name.text = rideDetail.driverCarBrand[tag]
        lbl_car_comfort.text = rideDetail.driverCarComfort[tag]
        lbl_schedule.text = rideDetail.driverSchedule[tag]
        lbl_detour.text = rideDetail.driverDetour[tag]
        lbl_luggage_size.text = rideDetail.driverLuggageSize[tag]
        lbl_number_of_seats.text = rideDetail.driverSeatAvailable[tag] + " SEAT"
    }
    
    func setUpProfileImage()
    {
        img_view_profile.layer.borderWidth = 1
        img_view_profile.layer.masksToBounds = false
        img_view_profile.layer.borderColor = UIColor.clear.cgColor
        img_view_profile.layer.cornerRadius = img_view_profile.frame.height/2
        img_view_profile.clipsToBounds = true
        img_view_profile.sd_setImage(with: URL(string: rideDetail.driverImageURL[tag]), placeholderImage: UIImage(named: "loading-icon-1"), options: [.progressiveDownload, .continueInBackground])
    }
    
    func setUpScrollView()
    {
        let screenSize = UIScreen.main.bounds
        var scrollView: UIScrollView!
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scrollView.contentSize = CGSize(width: screenWidth, height: 700)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(view_view)
        view.addSubview(scrollView)
     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookingseat"
        {
         let dvc = segue.destination as! BookRideViewController
            dvc.imageURL = imageURL
            dvc.rideDetail = rideDetail
            dvc.tag = tag
        }
    }
}
