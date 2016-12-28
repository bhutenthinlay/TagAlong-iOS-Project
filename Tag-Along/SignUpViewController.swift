//
//  SignUpViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/8/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import Alamofire
import AwesomeButton
class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    typealias  JSONstandard = [String: AnyObject]
    var name: String!
    var email: String!
    var password: String!
    var repassword: String!
    var language: String!
    var registrationURL = "https://tag-along.net/webservice.php"
    @IBAction func btn_sign_up(_ sender: AwesomeButton) {
        email = txt_field_email.text!
        name = txt_field_name.text!
        password = txt_field_password.text!
        repassword = txt_field_repassword.text!
        language = txt_field_prefered_language.text!
        if name == "" || email == "" || password == "" || repassword == "" || language == ""
        {
           alert(alert: "Alert", message: "Field cannot be blank")
        }
        
        else if !isValidEmail(testStr: email)
        {
        alert(alert: "Alert", message: "Please enter a valid email")
        }
        
        else if password.characters.count < 8{
        alert(alert: "Alert", message: "Password should be minimum 8 characters")
        }
        else if password != repassword{
         alert(alert: "Alert", message: "Password doesn't match")
        }
        else {
            DispatchQueue.main.async {
                self.callAlamo(url: self.registrationURL, email: self.email, password: self.password, name: self.name, language: self.language)
              self.startSpinner()
                
            }

        }
        
    }
    @IBOutlet weak var txt_field_repassword: UITextField!
    @IBOutlet weak var txt_field_password: UITextField!
    @IBOutlet weak var txt_field_email: UITextField!
    @IBOutlet weak var txt_field_name: UITextField!
    @IBOutlet weak var txt_field_prefered_language: UITextField!
    @IBOutlet weak var picker_language: UIPickerView!
    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        

    }
    
    var listOfLanguage = ["English", "Tibetan", "Hindi"]
    //MARK: - VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_field_email.delegate = self
        txt_field_name.delegate = self
        txt_field_password.delegate = self
        txt_field_repassword.delegate = self
        txt_field_email.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        txt_field_name.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        txt_field_password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        txt_field_repassword.attributedPlaceholder = NSAttributedString(string: "Re-password", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
     
        picker_language.isHidden = true
       // activity_indicator.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        txt_field_prefered_language.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        // Do any additional setup after loading the view.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
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

    //MARK: - CALLING WEBSERVICE ALOMO
    func callAlamo(url: String, email: String, password: String, name: String, language: String)
    {
        
        let params: Parameters = ["type": "register", "vFirstName": name, "vLastName": "", "vEmail": email, "vPassword": password, "vLanguageCode": language]
        Alamofire.request(url, method: .post, parameters: params).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        })
        
        
    }
    func parseData(JSONData: Data){
        do{
            var readableJSON  = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONstandard
            print(readableJSON)
           stopSpinner()
            
            if let action = readableJSON["action"]
            {
                if action as! Int == 1
                {
                    
                    navigationController?.popViewController(animated: true)
                    
                    dismiss(animated: true, completion: nil)
                    
                    
                }else if action as! Int == 0
                {
                    if let message = readableJSON["message"]{
                    alert(alert: "No Success", message: message as! String)
                    }
                 }
                
            }
//                else if action as! Int == 0{
//                    if let message = readableJSON["message"]{
//                        alert(alert: "no success", message: message as! String)
//                    }
//                    
//                }
//            }
            //            if let tracks = readableJSON["tracks"] as? JSONstandard
            //            {
            //                if let items = tracks["items"]
            //                {
            //                    for i in 0..<items.count{
            //                        let item = items[i] as! JSONstandard
            //                        let name = item["name"] as? String
            //
            //                        names.append(name!)
            //
            //                        self.tableView.reloadData()
            //                    }
            //
            //                }
            //            }
        }
        catch{
            print(error)
        }
    }

    //McRK: - VALIDATE EMAIL
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    //MARK: - ALERT
    func alert(alert: String, message: String)
    {
        let alert = UIAlertController(title: alert, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return listOfLanguage[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfLanguage.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txt_field_prefered_language.text = self.listOfLanguage[row]
        
        self.picker_language.isHidden = true
    }
    //MARK: - TEXT FIELD DELEGATE METHODS
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.txt_field_name{
        
        }
        if textField == self.txt_field_prefered_language
        {
          self.picker_language.isHidden = false
            textField.endEditing(true)
            
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_field_name
        {
          txt_field_name.resignFirstResponder()
        }
        else if textField == txt_field_email
        {
          txt_field_email.resignFirstResponder()
            
        }
        else if textField == txt_field_password
        {
         txt_field_password.resignFirstResponder()
            
        }
        else if textField == txt_field_repassword{
          txt_field_repassword.resignFirstResponder()
        }
        return true
    }
    //MARK: - DISMISS KEYBOARD
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
   //MARK: - MOVE KEYBOARD UP
    func keyboardWasShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            
        })
    }

}
