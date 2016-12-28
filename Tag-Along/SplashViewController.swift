//
//  SplashViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/26/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        readFromShared()
        customizeNavigationbar()
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - STOP SPINNER
    func stopSpinner(){
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true);
        view.isUserInteractionEnabled = true
        
    }
    
    
    //MARK: - START SPINNER
    func startSpinner()
    {
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        
        spinnerActivity.label.text = "Loading";
        
        spinnerActivity.detailsLabel.text = "Please Wait!!";
        
        spinnerActivity.isUserInteractionEnabled = false;
        
        view.isUserInteractionEnabled = false
        
    }

    //MARK: - READ FROM SHARED
    func readFromShared(){
        let preferences = UserDefaults.standard
        startSpinner()
        let key = "memberID"
        
        if preferences.object(forKey: key) == nil {
            print("nothing saved")
            stopSpinner()
            performSegue(withIdentifier: "splashtologin", sender: self)
        } else {
            //  let currentLevel = preferences.integer(forKey: currentLevelKey)
            stopSpinner()
            let nameNew = preferences.object(forKey: key)
            let memberID = nameNew as! String!
            print("Member id is: \(memberID!)")
            //goToHome()
            performSegue(withIdentifier: "splashtohome", sender: self)
        }
    }
    func customizeNavigationbar()
    {
        navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = barTintColor
        navigationController?.navigationBar.barTintColor = barTintColor
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
