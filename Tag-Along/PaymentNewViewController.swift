//
//  PaymentNewViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/19/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class PaymentNewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! NewCardTableViewCell
        return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! PaypalTableViewCell
            return cell

        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
          return 261
        }
        else{
         return 159
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
