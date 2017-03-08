//
//  MyCarsViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 1/24/17.
//  Copyright © 2017 Tenzin Thinlay. All rights reserved.
//

import UIKit

class MyCarsViewController: UIViewController {

    @IBAction func bar_btn_message(_ sender: UIBarButtonItem) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatListViewController") as? ChatListViewController {
            //            viewController.newsObj = newsObj
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.updateViewController(value: true)
    }
    @IBOutlet weak var lbl_car_comfort: UILabel!
    @IBOutlet weak var lbl_car_name: UILabel!
    @IBOutlet weak var lbl_number_of_seats: UILabel!
    @IBOutlet weak var img_view_car: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationbar()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        lbl_car_name.isUserInteractionEnabled = true
        lbl_car_name.addGestureRecognizer(tapGesture)
   
        // Do any additional setup after loading the view.
    }
    func tapBlurButton(_ sender: UITapGestureRecognizer){
      print(123)
    }
    
    func customizeNavigationbar()
    {
        navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.08, green:0.2, blue:0.38, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.08, green:0.2, blue:0.38, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
