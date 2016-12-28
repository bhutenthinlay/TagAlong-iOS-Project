//
//  MyProfileViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/10/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
     var isEditAble = true
    //MARK: - Outlets
    
    @IBOutlet weak var scrollviewheight: NSLayoutConstraint!
    
    @IBAction func btn_edit_profile(_ sender: UIButton) {
        if isEditAble{
            textfieldEditable()
            isEditAble = false
            sender.setTitleColor(UIColor.gray, for: .normal)
            sender.setImage(UIImage(named: "editblack"), for: .normal)
        }
        else{
            textFieldDisableEditing()
            isEditAble = true
            sender.setTitleColor(UIColor.white, for: .normal)
            sender.setImage(UIImage(named: "edit"), for: .normal)
        }

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
    
    @IBOutlet weak var txt_field_description: UITextView!
    
    
    @IBOutlet weak var txt_field_contact: UITextField!
   
    @IBOutlet weak var txt_field_email: UITextField!
    
    @IBOutlet weak var txt_field_address: UITextView!
    
    @IBOutlet weak var scroll_view: UIScrollView!
    
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
        var frameRect = txt_field_address.frame
        
       // frameRect.size.height = 53
        txt_field_address.frame = frameRect
    }
    
    // MARK: - Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
         customizeNavigationbar()
         customizeImageView()
         textFieldDisableEditing()
        
         self.navigationController?.isNavigationBarHidden = false
         self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
         self.navigationController?.navigationBar.shadowImage = UIImage()
        // setting scroll view height
        scroll_view.contentSize.height = 780
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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

  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: - DISMISS KEYBOARD
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


}
