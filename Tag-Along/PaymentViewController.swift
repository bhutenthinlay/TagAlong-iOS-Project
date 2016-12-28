//
//  PaymentViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/12/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import DLRadioButton
class PaymentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
  
    @IBOutlet weak var table_view: UITableView!
  
    @IBOutlet weak var view_view: UIView!
    var cardNumber = [String]()
    var cardImage = [UIImage]()
    @IBAction func btn_back(_ sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        cardNumber = ["5023 2232 2213 1234", "5023 2232 2213 1784"]
        cardImage = [UIImage(named: "mastercard")!, UIImage(named: "vissa")!]
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scrollView.contentSize = CGSize(width: screenWidth, height: 603)
        scrollView.bounces = false
        
        scrollView.addSubview(view_view)
        view.addSubview(scrollView)
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardNumber.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CardTableViewCell
        cell.lbl_card_number.text = cardNumber[indexPath.row]
        cell.image_view_card.image = cardImage[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
          let cell = tableView.cellForRow(at: indexPath) as! CardTableViewCell
            cell.btn_radio.isSelected = true
     
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CardTableViewCell
        cell.btn_radio.isSelected = false
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
