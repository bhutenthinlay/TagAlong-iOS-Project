//
//  LoginViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/8/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import AwesomeButton
import Alamofire
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    var loginURL = "https://tag-along.net/webservice.php"
    var id: String!
    var firstName: String!
    var lastName: String!
    var pictureURL: String!
    let loginDetail = LoginDetails()

  
    @IBOutlet weak var btn_facebook_login: FBSDKLoginButton!
   

    typealias  JSONstandard = [String: AnyObject]
    
    @IBOutlet weak var txt_field_email: UITextField!
    
        @IBOutlet weak var txt_field_password: UITextField!

       var email: String!
    var password: String!
    //MARK: - READ FROM SHARED
    func readFromShared(){
        let preferences = UserDefaults.standard
        
        let key = "memberID"
        
        if preferences.object(forKey: key) == nil {
            print("nothing saved")
        } else {
            //  let currentLevel = preferences.integer(forKey: currentLevelKey)
            let nameNew = preferences.object(forKey: key)
            let memberID = nameNew as! String!
            print("Member id is: \(memberID!)")
            //goToHome()
            performSegue(withIdentifier: "logintohome", sender: self)
        }
    }

    //MARK: - VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_field_email.delegate = self
        txt_field_password.delegate = self
        txt_field_email.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSForegroundColorAttributeName: UIColor.white])
        txt_field_password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.white])
        btn_facebook_login.readPermissions = ["public_profile", "email", "user_friends"]
        btn_facebook_login.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        customizeNavigationbar()
     
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            alert(alert: "No Connectivity", message: "Please connect to internet...")
        case .online(.wwan), .online(.wiFi):
            print("Connected via WWAN")
        }
    }
    
    func networkStatusChanged(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo
        print(userInfo)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        //readFromShared()
        customizeNavigationbar()
    }
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    //MARK: - BUTTON LOGIN
    @IBAction func btn_login(_ sender: AwesomeButton) {
        email = txt_field_email.text!
        password = txt_field_password.text!
        if email == "" && password == ""
        {
           alert(alert: "Alert", message: "Email or Password field cannot be nil")
        }
        else if !isValidEmail(testStr: email)
        {
          alert(alert: "Alert", message: "Please enter a valid email format")
        }
        else if password.characters.count < 8
        {
          alert(alert: "Alert", message: "Password should have minimum of 8 characters")
        }
        else {
            let status = Reach().connectionStatus()
            switch status {
            case .unknown, .offline:
                print("Not connected")
                alert(alert: "No Connectivity", message: "Please connect to internet...")
            case .online(.wwan), .online(.wiFi):
                print("Connected via WWAN")
                DispatchQueue.main.async {
                    self.callAlamo(url: self.loginURL, email: self.email, password: self.password)
                    self.startSpinner()
                    self.writeShared(key: "state", value: "1")
                }

            }

        }
    }
    //MARK: - STOP SPINNER
    func stopSpinner(){
      //  MBProgressHUD.hideAllHUDs(for: self.view, animated: true);
        view.isUserInteractionEnabled = true
    }
    //MARK: - START SPINNER
    func startSpinner()
    {
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinnerActivity.label.text = "Loading"
        spinnerActivity.detailsLabel.text = "Please Wait!!"
        spinnerActivity.isUserInteractionEnabled = false
        view.isUserInteractionEnabled = false
    }
    //MARK: -  WRITE ON SHARED PREFERENCE
    func writeShared(key: String, value: String)
    {
        let preferences = UserDefaults.standard
        
        let key = key
        
        let value = value
           // preferences.setInteger(value, forKey: key)
            preferences.set(value, forKey: key)
        
        
        //  Save to disk
        let didSave = preferences.synchronize()
        
        if !didSave {
            //  Couldn't save (I've never seen this happen in real world testing)
        }
    
    }
    
    //MARK: - CALLING WEBSERVICE ALOMO
    func callAlamo(url: String, email: String, password: String)
    {
        
        let params: Parameters = ["vEmail": email, "vPassword": password, "type": "login"]
        Alamofire.request(url, method: .post, parameters: params).responseJSON(completionHandler: {
            response in
            print("response is: \(response)")
            self.parseData(JSONData: response.data!)
        })
        
        
    }
    func parseData(JSONData: Data){
        do{
            var readableJSON  = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONstandard
            print(readableJSON)
            stopSpinner()
            //self.activity_indicator.stopAnimating()
            //self.activity_indicator.isHidden = true
            var memberID: Int!
            var firstName: String!
            var email: String!
            if let action = readableJSON["action"]
            {
              if action as! Int == 1
              {
                if let mem = readableJSON["iMemberId"]
                {
                     print("member is :\(mem)")
//                  memberID = mem as! Int
//                   
//                    let memberIDNew = memberID
                    writeShared(key: "memberID", value: String(describing: "\(mem)"))
                }
                if let _ = readableJSON["vEmail"]
                {
                    email = readableJSON["vEmail"] as! String

                }
                if let _ = readableJSON["vFirstName"]
                {
                  firstName = readableJSON["vFirstName"] as! String
                    writeShared(key: "name", value: firstName)
                    
                }
                
                  goToHome()
                
              }
              else if action as! Int == 0{
                if let message = readableJSON["message"]{
                alert(alert: "no success", message: message as! String)
                }
                
                }
            }
        }
        catch{
            print(error)
        }
    }

    
    //MARK: - ALERT
    func alert(alert: String, message: String)
    {
        let alert = UIAlertController(title: alert, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - VALIDATE EMAIL STRING
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    //MARK: - GO TO HOME
    func goToHome()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.updateViewController(value: true)

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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 100)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 100)
    }
  
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_field_email{
            txt_field_email.resignFirstResponder()
         return true
        }
        else if textField == txt_field_password {
            txt_field_password.resignFirstResponder()
         return true
        }
        else{
          return true
        }
    
    }
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    //MARK: - DISMISS KEYBOARD
   func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    //MARK: - FACEBOOK LOGIN DELEGATE
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("Response from facebook")
        if let token = FBSDKAccessToken.current(){
          fetchProfile()
            
        }
        
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    //MARK: - FETCH PROFILE
    func fetchProfile(){
        print("fetching profile")
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            alert(alert: "No Connectivity", message: "Please connect to internet...")
        case .online(.wwan), .online(.wiFi):
            print("Connected via WWAN")
            startSpinner()
            let parameter = ["fields":"email, first_name, last_name, picture.type(large)"]
            FBSDKGraphRequest(graphPath: "me", parameters: parameter).start { (connection, result, error) -> Void  in
                if error != nil
                {
                    print("error is : \(error)")
                    print("user:\(result)")
                    
                }
                else{
                    print(result!)
                    print("inside conversion")
                    
                    self.parseDataFromFacebook(data: result as! LoginViewController.JSONstandard)
                    
                    
                    
                }
                
            }
            
       
        }
    

        
        
    }
    func parseDataFromFacebook(data: JSONstandard){
        
      stopSpinner()
               do{
            try
                print("facebook: \(data)")
            if let first_name = data["first_name"]
            {
                firstName = first_name as! String
                print(firstName)
                writeShared(key: "state", value: "0")
                writeShared(key: "first_name", value: firstName)
            }
            if let last_name = data["last_name"] {
              lastName = last_name as! String
                writeShared(key: "last_name", value: lastName)
            }
            if let e_mail = data["email"]
            {
              email = e_mail as! String
                loginDetail.email = e_mail as! String
                print("email from model is: \(loginDetail.email)")
                
                writeShared(key: "email", value: email)
                print("email is: \(email!)")
            }
            if let i_d = data["id"]
            {
              id = i_d as! String
                print("id is \(id!)")
                
               
            }
            if let picture = data["picture"] as? JSONstandard
            {
              if let dataNew = picture["data"] as? JSONstandard
              {
                 if let url = dataNew["url"]
                 {
                    pictureURL = url as! String
                    print(pictureURL)
                    writeShared(key: "imageURL", value: pictureURL)
                }
              }
            }
            callAlamo(url: loginURL, email: email!, fbid: id!)
            startSpinner()
            
           

            
            }
        catch{
            print(error)
        }
    }
    //MARK: - CALLING WEBSERVICE ALOMO
    func callAlamo(url: String, email: String, fbid: String)
    {
        
        print("\(email) and id is \(fbid)")
        
        let params: Parameters = ["type": "login_with_fb", "vEmail": email, "iFBId": fbid, "name": firstName + " " + lastName, "vImage": pictureURL]
        Alamofire.request(url, method: .post, parameters: params).responseJSON(completionHandler: {
            response in
            self.parseDataFacebook(JSONData: response.data!)
        })
        
        
        
    }
    func parseDataFacebook(JSONData: Data){
        do{
            var readableJSON  = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONstandard
            print("Response from server 1: \(readableJSON)")
            stopSpinner()
            var memberID: String!
            if let action = readableJSON["action"]
            {
                if action as! Int == 1
                {
                    print("first time facebook login")
                    if let mem = readableJSON["iMemberId"]
                    {
                        print("member is :\(mem)")
                        memberID = mem as! String
                        
                        let memberIDNew = memberID!
                        writeShared(key: "memberID", value: memberIDNew)
                    }

                    goToHome()
                    
                }else if action as! Int == 0
                {
                    print("logging in with facebook again")
                    callAlamo(url: loginURL, email: email, password: "")
                    startSpinner()
//                    if let message = readableJSON["message"]{
//                        alert(alert: "No Success", message: message as! String)
//                    }
                     // goToHome()
                }
                else if action as! Int == 3
                {
                    print("logging in with facebook again")
                    callAlamo(url: loginURL, email: email, fbid: id, fname: firstName, lname: lastName, imageURL: pictureURL)
                    startSpinner()
                    
                }
                
            }
                   }
        catch{
            print(error)
        }
    }
    //MARK: - CALLING WEBSERVICE ALOMO
    func callAlamo(url: String, email: String, fbid: String, fname: String, lname: String, imageURL: String)
    {
        
        let params: Parameters = ["type": "register", "vFirstName": fname, "vLastName": lname, "vEmail": email, "iFBId": fbid, "vImage": imageURL]
        Alamofire.request(url, method: .post, parameters: params).responseJSON(completionHandler: {
            response in
            self.parseDataForFacebookRegister(JSONData: response.data!, email: email, name: lname)
        })
        
        
    }
    func parseDataForFacebookRegister(JSONData: Data, email: String, name: String){
        do{
            var readableJSON  = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONstandard
            print("Response from server: \(readableJSON)")
            stopSpinner()
            var memberID: Int!
            if let action = readableJSON["action"]
            {
                if action as! Int == 1
                {
                    if let mem = readableJSON["iMemberId"]
                    {
                        if let imageURL = readableJSON["vImage"]{
                            var newImageURL: String?
                            if let newImageURL1 = imageURL as? String
                            {
                                newImageURL = "\(newImageURL1)"
                                
                            }
                            else
                            {
                                newImageURL = "http://www.diaglobal.org/_Images/member/Generic_Image_Missing-Profile.jpg"
                            }
                            print("the member id is : \(mem as! Int)")
                            writeShared(key: "memberID", value: "\(mem as! Int)")
                            let values = ["name": name, "email": email, "profileImageURL": newImageURL!] as [String : Any]
                            self.registerUserIntoDatabaseWithUid(memberID: "\(mem as! Int)", values: values as [String : AnyObject])
                        }

                        
                    }

                    goToHome()
                    
                }else if action as! Int == 0
                {
                    if let message = readableJSON["message"]{
                        alert(alert: "No Success", message: message as! String)
                    }
                }
                
            }
        }
        catch{
            print(error)
        }
    }
    func registerUserIntoDatabaseWithUid(memberID: String, values: [String: AnyObject]){
        let ref = FIRDatabase.database().reference()
        let userReference = ref.child("users").child(memberID)
        userReference.updateChildValues(values, withCompletionBlock: {(error, ref)
            in
            if error != nil{
                print("error is \(error!)")
                return
            }
            else{
                print("Saved user successfully into firebas db")
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
            
            
        })
    }
    


}
