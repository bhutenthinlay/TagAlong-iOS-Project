//
//  MenuViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/8/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
   
    var name: String!
    @IBOutlet weak var table_view: UITableView!
    var menuList = [String]()
    var menuIcon = [UIImage]()
    var imageURL: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuList = ["My Profile", "My Car", "My Booking", "My Dashboard", "Find a ride", "Offer a ride", "Setting", "How it works", "Latest rides", "Logout"]
        menuIcon = [UIImage(named: "user")!, UIImage(named: "car")!, UIImage(named: "booking")!, UIImage(named: "dash")!, UIImage(named: "search")!, UIImage(named: "offer")!, UIImage(named: "settings")!, UIImage(named: "help")!, UIImage(named: "latest-ride")!, UIImage(named: "latest-ride")!]
          self.navigationController?.isNavigationBarHidden = true
        readFromShared()
        
                // Do any additional setup after loading the view.
    }
    //MARK: - CLEAR SHARED USERDEFAULTS
    func clearShared()
    {
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        
        
        
        for key in Array(UserDefaults.standard.dictionaryRepresentation().keys) {
            UserDefaults.standard.removeObject(forKey: key)
        }
        
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
    //MARK: - READ FROM SHARED PREFERENCE
    func readFromShared(){
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "state") == nil{
          print("nothing saved")
        }
        else if preferences.object(forKey: "state") as! String == "1"{
            let key = "name"
            
            if preferences.object(forKey: key) == nil {
                print("nothing saved ")
            }
            else {
                //  let currentLevel = preferences.integer(forKey: currentLevelKey)
                let nameNew = preferences.object(forKey: key)
                name = nameNew as! String!
                print("Member id is: \(name)")
            }

        }
        else if preferences.object(forKey: "state") as! String == "0"
        {
            if preferences.object(forKey: "first_name") == nil{
                print("nothing saved from facebook")
            }
            else if preferences.object(forKey: "last_name") == nil{
                print("nothing saved from facebook")
            }
            else {
                let fname = preferences.object(forKey: "first_name") as! String
                let lname = preferences.object(forKey: "last_name") as! String
                imageURL = preferences.object(forKey: "imageURL") as! String
                name = fname + " " + lname
            }
        }
        
        
    }
// MARK: - TABLEVIEW DELEGE METHODS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "profile") as! ProfileTableViewCell
      
        cell.img_profile.layer.borderWidth = 1
        cell.img_profile.layer.masksToBounds = false
        cell.img_profile.layer.borderColor = UIColor.clear.cgColor
        cell.img_profile.layer.cornerRadius = cell.img_profile.frame.height/2
        
        cell.img_profile.clipsToBounds = true
            if let _ = imageURL{
                cell.img_profile.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading-icon-1"), options: [.progressiveDownload, .continueInBackground])
                cell.img_view_back_ground.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading-icon-1"), options: [.progressiveDownload, .continueInBackground])
            }
        cell.lbl_name.text = name

         return cell
        }
        else {
          let cell = tableView.dequeueReusableCell(withIdentifier: "menulist") as! MenuListTableViewCell
            cell.lbl_menu_list.text = menuList[indexPath.row - 1]
            cell.img_view_menu_icon.image = menuIcon[indexPath.row - 1]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
        return 288
        }
        else{
         return 58
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            table_view.deselectRow(at: indexPath, animated: true)
        }
        else if indexPath.row == 1
        {
          performSegue(withIdentifier: "myprofile", sender: self)
        }
            
        else if indexPath.row == 4{
            performSegue(withIdentifier: "dashboard", sender: self)
        }
        else if indexPath.row == 9{
           performSegue(withIdentifier: "driver_profile", sender: self)
        }
        else if indexPath.row == 10{
            clearShared()
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
           performSegue(withIdentifier: "logout1", sender: self)
        }
    }
   
    


}
