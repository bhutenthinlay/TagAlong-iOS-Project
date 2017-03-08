//
//  ChatListViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 2/6/17.
//  Copyright © 2017 Tenzin Thinlay. All rights reserved.
//

import UIKit
import Firebase

class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var table_view: UITableView!
    
    var messages = [Message]()
    var userMessages = [Message]()
    var messagesDictionary = [String: Message]()
    //    let message = Message()
    var chatPartnerId: String?
    var memberID: String?
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
        
        readFromShared()
        checkIfUserIsLoggedIn()
        observeUserMessages()
        // Do any additional setup after loading the view.
    }

    func checkIfUserIsLoggedIn(){
        messages.removeAll()
        messagesDictionary.removeAll()
       
        activityIndicator.startAnimating()
        print("table is getting reloaded from checkIfUserIsLoggedIn")
       // table_view.reloadData()
            
            FIRDatabase.database().reference().child("users").child(memberID!).observeSingleEvent(of: .value, with: { (snapshot) in
                print("snap shot is: \(snapshot)")
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    self.navigationItem.title = dictionary["name"] as? String
                    self.activityIndicator.stopAnimating()
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: self, action: #selector(self.composeNewMessage))
                }
            }, withCancel: nil)
        
    }
    func composeNewMessage()
    {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ComposeNewMessageViewController") as? ComposeNewMessageViewController {

            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
        


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
    
    
    func observeUserMessages()
    {
        
        guard let uid = memberID else {
            return
        }
        
        let ref = FIRDatabase.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            // print(snapshot)
            let messageId = snapshot.key
            print("message id: \(messageId)")
            let messageRef = FIRDatabase.database().reference().child("messages").child(messageId)
            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    let message = Message()
                    print(dictionary)
                    message.setValuesForKeys(dictionary)
                    // print(self.message)
                    
                    // self.messages.append(self.message)
                    let chatPartnerId1: String?
                    print("message.fromid \(message.fromId), \(message.toId), \(self.memberID)")
                    if message.fromId == self.memberID {
                        chatPartnerId1 = message.toId
                    }
                    else{
                        chatPartnerId1 = message.fromId
                    }
                    if let toId = chatPartnerId1{
                        //   if let toId = message.toId{
                        self.messagesDictionary[toId] = message
                        self.messages = Array(self.messagesDictionary.values)
                        print("message is: \(self.messages)")
                        self.messages.sort(by: { (message1, message2) -> Bool in
                            return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
                        })
                    }
                    self.timer?.invalidate()
                    self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleTableReload), userInfo: nil, repeats: false)
                    
                    
                    // print(self.messages)
                    
                }
                
            }, withCancel: nil)
        }, withCancel: nil)
        
        
    }
    var timer: Timer?
    func handleTableReload()
    {
        DispatchQueue.main.async {
            self.table_view.reloadData()
            print("table is getting reloaded")
            
        }
        
        
    }
    
    
    //MARK: - TABLEVIEW DATASOURCE METHODS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChatListTableViewCell
        
        let timestamp = messages[indexPath.row].timestamp
        let timestampActualDate = NSDate(timeIntervalSince1970: (timestamp?.doubleValue)!)
        let date = DateFormatter()
        date.dateFormat = "hh:mm a"
        cell.lbl_last_message.text = self.messages[indexPath.row].text
        cell.lbl_time.text = date.string(from: timestampActualDate as Date)
        
        if self.messages[indexPath.row].fromId == memberID {
            self.chatPartnerId = self.messages[indexPath.row].toId
        }
        else{
            self.chatPartnerId = self.messages[indexPath.row].fromId
        }
        print("chat partner is: \(self.chatPartnerId)")
        
        if let id = chatPartnerId{
            let ref = FIRDatabase.database().reference().child("users").child(id)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                print("new snapshot is: \(snapshot)")
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    cell.lbl_name.text = dictionary["name"] as? String
                    
                    cell.img_view_profile.sd_setImage(with: URL(string: dictionary["profileImageURL"] as! String), placeholderImage: UIImage(named: "add_user"), options: [.continueInBackground, .progressiveDownload])
                }
            }, withCancel: nil)
        }
    return cell
    }
   

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatController = LGChatController()
        let lgchatinput = LGChatInput()
        chatController.chatPartnerId = returnChatPartnerId(message: messages[indexPath.row])
        chatController.currentUserName = memberID!
        lgchatinput.userid = returnChatPartnerId(message: messages[indexPath.row])
        self.navigationController?.pushViewController(chatController, animated: true)

    }
    func returnChatPartnerId(message: Message) -> String
    {
        return (message.fromId == memberID ? message.toId : message.fromId)!
    }


}
