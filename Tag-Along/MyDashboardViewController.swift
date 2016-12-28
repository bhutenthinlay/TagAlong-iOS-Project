//
//  MyDashboardViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/12/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class MyDashboardViewController: UIViewController {

  
    @IBAction func btn_my_booking(_ sender: UIButton) {
       
    }
   
    @IBAction func btn_rides_offered(_ sender: UIButton) {
        
    }
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(controller, animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
