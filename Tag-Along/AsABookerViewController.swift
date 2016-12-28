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
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingStatus = ["Active", "Not Active", "Active"]
        paymentStatus = ["Paid", "Not Paid", "Not Paid"]
        price = ["321", "453", "100"]
        imageURL = ["https://upload.wikimedia.org/wikipedia/commons/8/87/Mani_Zadeh_Profile.jpg", "http://www.mba.hec.edu/var/hec_mba/storage/images/student-life/student-profiles/samer-abi-nader/332170-5-eng-GB/Samer-Abi-Nader_profile_image-HEC-Paris-MBA.jpg", "http://www.celebbra.com/wp-content/uploads/2016/05/Emilia-Clarke-Height-Weight-Bra-Pics-Profile.jpg"]
        name = ["Tenzin", "Tashi", "Dolma"]
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
        cell.img_view_profile.sd_setImage(with: URL(string:imageURL[indexPath.row]), placeholderImage: UIImage(named: "loading-icon-1"), options: [.progressiveDownload, .continueInBackground])
        cell.lbl_date.text = date[indexPath.row]
        cell.lbl_driver_name.text = name[indexPath.row]
        cell.lbl_time.text = time[indexPath.row]
        cell.lbl_price.text = price[indexPath.row]
        cell.lbl_state.text = "(\(bookingStatus[indexPath.row]))"
        cell.lbl_payment_status.text = "(\(paymentStatus[indexPath.row]))"
        cell.lbl_destination.text = destination[indexPath.row]
        cell.lbl_departure_from.text = departureFrom[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 271
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
