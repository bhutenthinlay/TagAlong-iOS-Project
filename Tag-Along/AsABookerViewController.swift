//
//  AsABookerViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/20/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class AsABookerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table_view: UITableView!
    var imageURL = [String]()
    var name = [String]()
    var departureFrom = [String]()
    var destination = [String]()
    var date = [String]()
    var time = [String]()
    var bookingStatus = [String]()
    var paymentStatus = [String]()
    var price = [String]()
    var numberOfSeats = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingStatus = ["Active", "Not Active", "Active"]
        paymentStatus = ["Paid", "Not Paid", "Not Paid"]
        price = ["321", "453", "100"]
        imageURL = ["https://www.cheme.cornell.edu/engineering/customcf/iws_ai_faculty_display/ai_images/mjp31-profile.jpg", "https://organicthemes.com/demo/profile/files/2012/12/profile_img.png", "https://assets.entrepreneur.com/content/16x9/822/20150406145944-dos-donts-taking-perfect-linkedin-profile-picture-selfie-mobile-camera-2.jpeg"]
        name = ["Tenzin Tashi", "Tashi Tsering", "Dolma Lhamo"]
        departureFrom = ["Delhi, India", "Ludhiana, India", "Bangalore, India"]
        destination = ["Jaipur, India", "Chennai, India", "Noida, India"]
        time = ["4:56 pm", "4:23 pm", "1:00pm"]
        date = ["25/ 06 2016","25/ 06 2016","25/ 06 2016"]
        price = ["100", "200", "250"]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return price.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AsABookerTableViewCell
      
        cell.lbl_date.text = date[indexPath.row]
      
        cell.lbl_time.text = time[indexPath.row]
        cell.lbl_price.text = price[indexPath.row] + " $"
        cell.lbl_name.text = name[indexPath.row]
        cell.img_view_profile_pic.sd_setImage(with: URL(string:imageURL[indexPath.row]), placeholderImage: UIImage(named: "loading-icon-1"), options: [.progressiveDownload, .continueInBackground])

        cell.lbl_destination.text = destination[indexPath.row]
        cell.lbl_departure_from.text = departureFrom[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
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
