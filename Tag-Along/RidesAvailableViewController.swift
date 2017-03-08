//
//  RidesAvailableViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/12/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import STRatingControl

class RidesAvailableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyProtocol {
  
    @IBAction func bar_btn_message(_ sender: UIBarButtonItem) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatListViewController") as? ChatListViewController {
            //            viewController.newsObj = newsObj
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    var ridesDetail = RidesDetails()
    // MARK: - outlets
    @IBAction func bar_btn_filter(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "filter", sender: self)
        
    }
    

    @IBOutlet weak var table_view: UITableView!

    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
       
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        

    }
    // MARK: - viewcontroller lifecycle
       override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
//        imageURL = ["https://assets.entrepreneur.com/content/16x9/822/20150406145944-dos-donts-taking-perfect-linkedin-profile-picture-selfie-mobile-camera-2.jpeg", "https://organicthemes.com/demo/profile/files/2012/12/profile_img.png", "http://www.american.edu/uploads/profiles/large/chris_palmer_profile_11.jpg"]
//        name = ["John doe", "Robin all", "Tashi Delek"]
//        departureFrom = ["Delhi, India", "Ludhiana, India", "Bangalore, India"]
//        destination = ["Jaipur, India", "Chennai, India", "Noida, India"]
//        time = ["4:56 pm", "4:23 pm", "1:00pm"]
//        date = ["25/ 06 2016","25/ 06 2016","25/ 06 2016"]
//        price = ["100", "200", "250"]
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did viewDidAppear")
        if ridesDetail.driverName.count > 0{
            print(ridesDetail.driverName[0])
            table_view.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    

    // MARK: - tableview functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ridesDetail.driverName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! IndividualRidesTableViewCell
      
        cell.img_view_driver.sd_setImage(with: URL(string: ridesDetail.driverImageURL[indexPath.row]), placeholderImage: UIImage(named: "loading-icon-1"), options: [.continueInBackground, .progressiveDownload])
       
        cell.lbl_destination.text = ridesDetail.driverDestinationTo[indexPath.row]
        
        
        cell.lbl_departure_from.text = ridesDetail.driverDepartureFrom[indexPath.row]
        
               cell.lbl_date.text = ridesDetail.driverDepartureDate[indexPath.row]
        
        
        cell.lbl_time.text = ridesDetail.driverDepartureTime[indexPath.row]
        
       
        cell.btn_price.setTitle(ridesDetail.driverPrice[indexPath.row], for: .normal)
      
        cell.lbl_driver_name.text = ridesDetail.driverName[indexPath.row]
        
        cell.ratingStar.rating = ridesDetail.driverRating[indexPath.row]
        
        return cell
    }
    var tag: Int!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tag = indexPath.row
        performSegue(withIdentifier: "ridedetail", sender: self)
        table_view.deselectRow(at: indexPath, animated: true)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ridedetail"
        {
           let dvc = segue.destination as! RidesDetailViewController
            
            
            if tag != nil{
            dvc.imageURL = ridesDetail.driverImageURL[tag]
                dvc.tag = tag
                dvc.rideDetail = ridesDetail
            }
            else{
             dvc.imageURL = "http://www.american.edu/uploads/profiles/large/chris_palmer_profile_11.jpg"
             
            }
        }
        else if segue.identifier == "filter"{
         let dvc = segue.destination as! FilterViewController
           dvc.myprotocol = self
            dvc.ridesDetail = ridesDetail
            
        }
    }
    func reloadTableViewData(array: [String]){
        if !(ridesDetail.driverName == array){
           ridesDetail.driverName = array
        }
        
    }
    func reloadTableViewData(ridesDetail: RidesDetails)
    {
      self.ridesDetail = ridesDetail
    }
}
extension DriverProfileTableViewCell: STRatingControlDelegate {
    
    func didSelectRating(control: STRatingControl, rating: Int) {
        print("Did select rating: \(rating)")
    }
    
}
