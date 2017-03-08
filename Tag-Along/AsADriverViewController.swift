//
//  AsADriverViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/14/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class AsADriverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
        imageURL = ["https://assets.entrepreneur.com/content/16x9/822/20150406145944-dos-donts-taking-perfect-linkedin-profile-picture-selfie-mobile-camera-2.jpeg", "https://organicthemes.com/demo/profile/files/2012/12/profile_img.png", "http://www.american.edu/uploads/profiles/large/chris_palmer_profile_11.jpg"]
        name = ["John doe", "Robin all", "Tashi Delek"]
        departureFrom = ["Delhi, India", "Ludhiana, India", "Bangalore, India"]
        destination = ["Jaipur, India", "Chennai, India", "Noida, India"]
        time = ["4:56 pm", "4:23 pm", "1:00pm"]
        date = ["25/ 06 2016","25/ 06 2016","25/ 06 2016"]
        price = ["100", "200", "250"]
        numberOfSeats = ["6", "3", "4"]

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return price.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AsADriverTableViewCell
//        cell.img_view_profile.sd_setImage(with: URL(string:imageURL[indexPath.row]), placeholderImage: UIImage(named: "loading-icon-1"), options: [.progressiveDownload, .continueInBackground])
        cell.lbl_date.text = date[indexPath.row]
        cell.lbl_time.text = time[indexPath.row]
        cell.lbl_price.text = price[indexPath.row] + " $"
      
      //  cell.lbl_payment_status.text = "(\(paymentStatus[indexPath.row]))"
        cell.lbl_destination.text = destination[indexPath.row]
        cell.lbl_departure_from.text = departureFrom[indexPath.row]
        cell.lbl_number_of_seats.text = "Seats " + numberOfSeats[indexPath.row]
        return cell
        
    }
}
