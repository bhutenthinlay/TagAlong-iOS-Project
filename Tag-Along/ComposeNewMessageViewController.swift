//
//  ComposeNewMessageViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 2/7/17.
//  Copyright © 2017 Tenzin Thinlay. All rights reserved.
//

import UIKit
import Firebase

class ComposeNewMessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var users = [Users]()
    var memberID: String?
   
    @IBOutlet weak var new_table_view: UITableView!{
        didSet{
           print("table view is set")
        }
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        readFromShared()
        fetchUser()
        // Do any additional setup after loading the view.
    }
    //MARK: - READ FROM SHARED
    func readFromShared(){
        let preferences = UserDefaults.standard
        
        let key = "memberID"
        
        if preferences.object(forKey: key) == nil {
            print("nothing saved")
        } else {
            //  let currentLevel = preferences.integer(forKey: currentLevelKey)
            let nameNew = preferences.object(forKey: key)
            memberID = nameNew as! String!
            print("Member id is: \(memberID!)")
            //goToHome()
            // performSegue(withIdentifier: "logintohome", sender: self)
        }
    }

    // MARK:- FETCH USERS
    func fetchUser(){
        startSpinner()
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            //        print(snapshot)
            self.stopSpinner()
            if let dictionary = snapshot.value as? [String: AnyObject]
            {
                let user = Users()
                user.id = snapshot.key
                user.setValuesForKeys(dictionary)
                print(user.name!, user.email!)
                self.users.append(user)
                DispatchQueue.main.async {
                    self.new_table_view.reloadData()
                }
                
            }
        }, withCancel: nil)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellone") as! ComposeNewMessageTableViewCell
        cell.lbl_name.text = users[indexPath.row].name
        cell.lbl_email.text = users[indexPath.row].email
         cell.img_view_profile.sd_setImage(with: URL(string: users[indexPath.row].profileImageURL!), placeholderImage: UIImage(named: "add_user"), options: [.continueInBackground, .progressiveDownload])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
        let chatController = LGChatController()
        let lgchatinput = LGChatInput()
        chatController.chatPartnerId = users[indexPath.row].id
        print("member id is this: \(memberID)")
        chatController.currentUserName = memberID!
        lgchatinput.userid = users[indexPath.row].id
        self.navigationController?.pushViewController(chatController, animated: true)
        
    }
    func returnChatPartnerId(message: Message) -> String
    {
        return (message.fromId == FIRAuth.auth()?.currentUser?.uid ? message.toId : message.fromId)!
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
}
