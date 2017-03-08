//
//  MyDashboardViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/12/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AwesomeButton

class MyDashboardViewController: UIViewController {
    var rating: Int!
    var earnedMoney: Int!
    var totalBooking: Int!
    var totalRides: Int!
    var amountPaid: Int!
    var totalRidesAlert: Int!
    
    @IBAction func bar_btn_message(_ sender: UIBarButtonItem) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatListViewController") as? ChatListViewController {
            //            viewController.newsObj = newsObj
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    var dashboardURL = "https://tag-along.net/webservice.php"
    typealias  JSONstandard = [String: AnyObject]
    var memberID: String!
    
    @IBAction func btn_rides_offered(_ sender: AwesomeButton) {
    }
    @IBAction func btn_my_booking(_ sender: AwesomeButton) {
    }
   
   
    @IBOutlet weak var lbl_alert: UILabel!
    @IBOutlet weak var lbl_rating: UILabel!
    @IBOutlet weak var lbl_paid_by_you: UILabel!
    @IBOutlet weak var lbl_money_saved: UILabel!
    @IBOutlet weak var lbl_my_booking: UILabel!
    @IBOutlet weak var lbl_rides_offered: UILabel!
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rides"
        {
          let dvc = segue.destination as! MyRideViewController
            dvc.segmentioIndex = 0
        }
        else if segue.identifier == "booking"{
         let dvc = segue.destination as! MyRideViewController
            dvc.segmentioIndex = 1
        }
    }
    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.updateViewController(value: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        readFromShared()
        callAlamo(url: dashboardURL, memberID: memberID)
        customizeNavigationbar()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func customizeNavigationbar()
    {
        navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.08, green:0.2, blue:0.38, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.08, green:0.2, blue:0.38, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //  self.navigationItem.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }
    //MARK: - READ FROM SHARED PREFERENCE
    func readFromShared(){
        let preferences = UserDefaults.standard
              let currentLevelKey = "memberID"
        
        if preferences.object(forKey: currentLevelKey) == nil {
            print("nothing saved")
        } else {
            //  let currentLevel = preferences.integer(forKey: currentLevelKey)
            memberID = preferences.object(forKey: currentLevelKey) as! String!
            print("Member id is: \(memberID!)")
        }
        
        
    }
    

    // MARK: - CALL ALAMO
    
    func callAlamo(url: String, memberID: String)
    {
        startSpinner()
        let params: Parameters = ["type": "my_dashboard", "MemberId": memberID]
        Alamofire.request(url, method: .post, parameters: params).responseJSON(completionHandler: {
            response in
            // print("response is: \(response)")
            self.parseData(JSONData: response.data!)
        })
        
        
    }
    func parseData(JSONData: Data){
        
        
        
        let json = JSON(Data: JSONData)
        print("json is: \(json)")
        stopSpinner()
        if let rating = json["rating"].int{
            self.rating = rating
            lbl_rating.text = "\(self.rating)"
        }
        else if let earnedMoney = json["earnedMoney"].int
        {
          self.earnedMoney = earnedMoney
            lbl_money_saved.text = "\(self.earnedMoney)"
        }
        else if let totalBooking = json["tot_bookings"].int{
          self.totalBooking = totalBooking
             lbl_my_booking.text = "\(self.totalBooking)"
        }
        else if let totalRides = json["tot_rides"].int
        {
          self.totalRides = totalRides
            lbl_rides_offered.text = "\(self.totalRides)"
        }
        else if let amountPaid = json["AmountPaid"].int
        {
          self.amountPaid = amountPaid
            lbl_paid_by_you.text = "\(self.amountPaid)"
        }
        else if let totalRidesAlert = json["tot_ride_alerts"].int
        {
          self.totalRidesAlert = totalRidesAlert
            lbl_alert.text = "\(self.totalRidesAlert)"
        }
            
       
    }
    
    //MARK: - STOP SPINNER
    func stopSpinner(){
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true);
        view.isUserInteractionEnabled = true
    }
    //MARK: - START SPINNER
    func startSpinner()
    {
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinnerActivity.label.text = "Loading"
        spinnerActivity.detailsLabel.text = "Please Wait!!"
        spinnerActivity.isUserInteractionEnabled = false
        view.isUserInteractionEnabled = false
    }


   

}
