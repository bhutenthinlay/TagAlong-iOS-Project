//
//  RidesAvailableViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/12/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit


class RidesAvailableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyProtocol {
    
    var name = [String]()
    var departureFrom = [String]()
    var destination = [String]()
    var date = [String]()
    var time = [String]()
    var price = [String]()
    var imageURL = [String]()
    var starRating = [Int]()
    // MARK: - outlets
    
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
        if name.count > 0{
            print(name)
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
        return price.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! IndividualRidesTableViewCell
        cell.img_view_driver.sd_setImage(with: URL(string:imageURL[indexPath.row]), placeholderImage: UIImage(named: "loading-icon-1"), options: [.continueInBackground, .progressiveDownload])
        cell.lbl_destination.text = destination[indexPath.row]
        
        cell.lbl_departure_from.text = departureFrom[indexPath.row]
        cell.lbl_date.text = date[indexPath.row]
        cell.lbl_time.text = time[indexPath.row]
        cell.btn_price.setTitle(price[indexPath.row], for: .normal)
        cell.lbl_driver_name.text = name[indexPath.row]
        
        
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
            dvc.imageURL = imageURL[tag]
            }
            else{
             dvc.imageURL = "http://www.american.edu/uploads/profiles/large/chris_palmer_profile_11.jpg"
            }
        }
        else if segue.identifier == "filter"{
         let dvc = segue.destination as! FilterViewController
           dvc.myprotocol = self
        }
    }
    func reloadTableViewData(array: [String]){
        if !(name == array){
           name = array
        }
    }
}

