//
//  DriversProfileViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/8/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class DriversProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var locationTo = [String]()
    var locationFrom = [String]()
    var date = [String]()
     var time = [String]()
     var numberOfSeats = [String]()
     var pricePerSeat = [String]()
    
    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(controller, animated: false, completion: nil)

    }
    @IBOutlet weak var table_view: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationbar()
        locationTo = ["Delhi, India", "Mumbai, India", "Bangalore, India"]
        locationFrom = ["Mumbai, India", "Delhi, India", "Chennai, India"]
        date = ["25/ 06 2016", "25/ 06 2016", "25/ 06 2016"]
        time = ["4:56 AM", "4:56 AM", "4:56 AM"]
        numberOfSeats = ["5", "4", "1"]
        pricePerSeat = ["400", "300", "100"]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
       
        
        // Do any additional setup after loading the view.
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

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DriverProfileTableViewCell
        cell.img_view_profile.layer.borderWidth = 1
        cell.img_view_profile.layer.masksToBounds = false
        cell.img_view_profile.layer.borderColor = UIColor.clear.cgColor
        cell.img_view_profile.layer.cornerRadius = cell.img_view_profile.frame.height/2
        
        cell.img_view_profile.clipsToBounds = true
        return cell
        }
        else{
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! DriverRidesPostedTableViewCell
            cell.lbl_to_location.text = locationTo[indexPath.row - 1]
            cell.lbl_from_location.text = locationFrom[indexPath.row - 1 ]
            cell.lbl_date.text = date[indexPath.row - 1]
            cell.lbl_time.text = time[indexPath.row - 1]
            cell.lbl_price_per_seat.text = "$ \(pricePerSeat[indexPath.row - 1]) / Seat"
            cell.lbl_number_of_seats.text = "\(numberOfSeats[indexPath.row - 1]) SEAT"
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationFrom.count + 1
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
        return 365
        }
        else {
         return 107            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
          table_view.deselectRow(at: indexPath, animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
