//
//  MyProfileViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/10/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class MyProfileViewController: UIViewController {
    
   
    //MARK: - Outlets and declarations
    var firstName: String!
    var lastName: String!
    var email: String!
    var imgURL: String!
    var phoneNumber: Int!
    var address: String!
    var language: String!
    var desc: String!
    var isEditAble = true
    var profileURL = "https://tag-along.net/webservice.php"
    typealias  JSONstandard = [String: AnyObject]
    var memberID: String!
    
    @IBOutlet weak var btn_save: UIButton!
   
    @IBAction func btn_save(_ sender: UIButton) {
            print("pressed")
            btn_save.isHidden = true
            textFieldDisableEditing()
            btn_edit_profile.isHidden = false
    }
   
    @IBOutlet weak var lbl_profile_name: UILabel!
    
    @IBOutlet weak var btn_edit_profile: UIButton!
    @IBAction func btn_edit_profile(_ sender: UIButton) {
       
            textfieldEditable()
            isEditAble = false
            btn_save.isHidden = false
            btn_edit_profile.isHidden = true
//            sender.setTitleColor(UIColor.gray, for: .normal)
//            sender.setImage(UIImage(named: "editblack"), for: .normal)
            
      
    }
    @IBOutlet weak var img_view_dropdown_copilot: UIImageView!
    @IBOutlet weak var img_view_dropdown_silence: UIImageView!
    @IBOutlet weak var img_view_dropdown_quiet: UIImageView!
    @IBOutlet weak var img_view_dropdown_nopets: UIImageView!
    @IBOutlet weak var img_view_dropdown_nosmoking: UIImageView!
    @IBOutlet weak var img_view_edit_language: UIImageView!
    @IBOutlet weak var img_view_edit_quick_desc: UIImageView!
    @IBOutlet weak var img_view_edit_address: UIImageView!
    @IBOutlet weak var img_view_edit_contact: UIImageView!
    @IBOutlet weak var img_view_edit_dob: UIImageView!
    @IBOutlet weak var img_view_edit_email: UIImageView!
    
    @IBOutlet weak var txt_field_dob: UITextField!
    @IBOutlet weak var txt_field_language: UITextField!
    @IBOutlet weak var txt_field_description: UITextView!
    @IBOutlet weak var txt_field_contact: UITextField!
    @IBOutlet weak var txt_field_email: UITextField!
    @IBOutlet weak var txt_field_address: UITextView!
    @IBOutlet weak var img_view_profile: UIImageView!
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
   // MARK: - customoze Textfield
   
    func customizeTextField()
    {
        let frameRect = txt_field_address.frame
        
       // frameRect.size.height = 53
        txt_field_address.frame = frameRect
    }
   // MARK: - Life cycle functions
   
    override func viewDidLoad() {
        super.viewDidLoad()
         btn_save.isHidden = true
         customizeNavigationbar()
        
         textFieldDisableEditing()
        
         self.navigationController?.isNavigationBarHidden = false
         self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
         self.navigationController?.navigationBar.shadowImage = UIImage()
        // setting scroll view height
       // scroll_view.contentSize.height = 780
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        readFromShared()
        callAlamo(url: profileURL, memberID: memberID)
        customizeImageView()
        
        // Do any additional setup after loading the view.
    }
   
    // MARK: - textfield editable
   
    func textfieldEditable(){
        
        txt_field_email.isUserInteractionEnabled = true
        txt_field_address.isUserInteractionEnabled = true
        txt_field_contact.isUserInteractionEnabled = true
        txt_field_description.isUserInteractionEnabled = true
        img_view_edit_email.isHidden = false
        img_view_edit_dob.isHidden = false
        img_view_edit_contact.isHidden = false
        img_view_edit_address.isHidden = false
        img_view_edit_language.isHidden = false
        img_view_edit_quick_desc.isHidden = false
        img_view_dropdown_nosmoking.isHidden = false
        img_view_dropdown_nopets.isHidden = false
        img_view_dropdown_quiet.isHidden = false
        img_view_dropdown_silence.isHidden = false
        img_view_dropdown_copilot.isHidden = false
        
        
    }
    
    // MARK: - text field not editable
    
    func textFieldDisableEditing()
    {
      txt_field_email.isUserInteractionEnabled = false
        txt_field_address.isUserInteractionEnabled = false
        txt_field_contact.isUserInteractionEnabled = false
        txt_field_description.isUserInteractionEnabled = false
        img_view_edit_email.isHidden = true
        img_view_edit_dob.isHidden = true
        img_view_edit_contact.isHidden = true
        img_view_edit_address.isHidden = true
        img_view_edit_language.isHidden = true
        img_view_edit_quick_desc.isHidden = true
        img_view_dropdown_nosmoking.isHidden = true
        img_view_dropdown_nopets.isHidden = true
        img_view_dropdown_quiet.isHidden = true
        img_view_dropdown_silence.isHidden = true
        img_view_dropdown_copilot.isHidden = true
    }
    
    // MARK: - Customoze Image View
    
    func customizeImageView()
    {
       img_view_profile.layer.borderWidth = 1
        img_view_profile.layer.masksToBounds = false
        img_view_profile.layer.borderColor = UIColor.clear.cgColor
        img_view_profile.layer.cornerRadius = img_view_profile.frame.height/2
        img_view_profile.clipsToBounds = true
       
        
    }
    
    // MARK: - Customoze Navigation bar
   
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

    //MARK: - DISMISS KEYBOARD
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    //MARK: - READ FROM SHARED PREFERENCE
    func readFromShared(){
        let preferences = UserDefaults.standard
        let currentLevelKey = "memberID"
        
        if preferences.object(forKey: currentLevelKey) == nil {
            print("nothing saved")
        } else {
            //  let currentLevel = preferences.integer(forKey: currentLevelKey)
            memberID = preferences.object(forKey: currentLevelKey) as! String!
            print("Member id is: \(memberID!)")
        }
        
        
    }
    
    
    // MARK: - CALL ALAMO
    
    func callAlamo(url: String, memberID: String)
    {
        startSpinner()
        let params: Parameters = ["type": "personal_information", "MemberId": memberID]
        Alamofire.request(url, method: .post, parameters: params).responseJSON(completionHandler: {
            response in
            // print("response is: \(response)")
            self.parseData(JSONData: response.data!)
        })
        
        
    }
    func parseData(JSONData: Data){
        
        
        
        let json = JSON(Data: JSONData)
        print("json is: \(json)")
        stopSpinner()
        
            if let fname = json["personal_information"]["vFirstName"].string
            {
               firstName = fname
            }
            else{
              firstName = ""
            }
            if let lname = json["personal_information"]["vLastName"].string
            {
               lastName = firstName + " " + lname
                lbl_profile_name.text = lastName
            
            }
            else {
              lastName = " Please enter your name"
                lbl_profile_name.text = lastName
            }
        if let email = json["personal_information"]["vEmail"].string{
          self.email = email
            txt_field_email.text = " " + self.email
        }
            if let imgurl = json["personal_information"]["url"].string{
               imgURL = imgurl
                print(self.imgURL)
                
                 img_view_profile.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "loading-icon-1"), options: [.progressiveDownload, .continueInBackground])
                
            }
            
            if let phonenumber = json["personal_information"]["vPhone"].int
            {
               phoneNumber = phonenumber
                txt_field_contact.text = "\(phoneNumber!)"
            }
            else {
               phoneNumber = 0000000000
                 txt_field_contact.text = "Please enter your contact number"
            }
            if let address = json["personal_information"]["vAddress"].string
            {
               self.address = address
                txt_field_address.text = address
            }
            else {
               self.address = "Please enter your address"
               txt_field_address.text = address
            }
            if let language = json["personal_information"]["vLanguageCode"].string
            {
              self.language = language
                txt_field_language.text = self.language
                
            }
            else{
               self.language = ""
                 txt_field_language.text = self.language
                
            }
            if let description = json["personal_information"]["tDescription"].string
            {
              self.desc = description
                txt_field_description.text = self.desc
            }
            else {
              self.desc = "Please enter description"
                txt_field_description.text = self.desc
            }
        if let dob = json["personal_information"]["iBirthYear"].string
        {
            txt_field_dob.text = dob
        }
        
        
        
    }
    
    //MARK: - STOP SPINNER
    func stopSpinner(){
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true);
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
    
    


}
