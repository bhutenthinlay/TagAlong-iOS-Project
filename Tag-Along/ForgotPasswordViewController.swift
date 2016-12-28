//
//  ForgotPasswordViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/8/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import AwesomeButton
import Alamofire

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    var loginURL = "https://tag-along.net/webservice.php"
    typealias  JSONstandard = [String: AnyObject]
    @IBAction func btn_send_email(_ sender: AwesomeButton) {
        let email = txt_field_email.text!
        DispatchQueue.main.async {
            self.startSpinner()
            self.callAlamo(url: self.loginURL, email: email)
            
//            self.activity_indicator.isHidden = false
//            
//            self.activity_indicator.startAnimating()
//            
        }

    }
    @IBOutlet weak var txt_field_email: UITextField!
    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    //MARK: - CALLING WEBSERVICE ALOMO
    func callAlamo(url: String, email: String)
    {
        
        let params: Parameters = ["vEmail": email, "type": "forgot_password"]
        print(email)
        Alamofire.request(url, method: .post, parameters: params).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        })
        
        
    }
    func parseData(JSONData: Data){
        do{
             let readableJSON  = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONstandard
            
                print(readableJSON)
            stopSpinner()
           
            if let action = readableJSON["action"]
            {
                if action as! Int == 1
                {
                    if let message = readableJSON["message"]{
                        alert(alert: "Success", message: message as! String)
                    }

                    //  goToHome()
                    
                }
                else if action as! Int == 0{
                    if let message = readableJSON["message"]{
                        alert(alert: "No success", message: message as! String)
                    }
                    
                }
            }
//            //            if let tracks = readableJSON["tracks"] as? JSONstandard
//            //            {
//            //                if let items = tracks["items"]
//            //                {
//            //                    for i in 0..<items.count{
//            //                        let item = items[i] as! JSONstandard
//            //                        let name = item["name"] as? String
//            //
//            //                        names.append(name!)
//            //
//            //                        self.tableView.reloadData()
//            //                    }
//            //
//            //                }
//            //            }
        }
        catch{
            print(error)
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
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        
        spinnerActivity.label.text = "Loading";
        
        spinnerActivity.detailsLabel.text = "Please Wait!!";
        
        spinnerActivity.isUserInteractionEnabled = false;
        view.isUserInteractionEnabled = false
        
    }

    
    //MARK: - ALERT
    func alert(alert: String, message: String)
    {
        let alert = UIAlertController(title: alert, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_field_email.delegate = self
        txt_field_email.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
      // customizeNavigationBar()
        // Do any additional setup after loading the view.
         self.navigationController?.isNavigationBarHidden = false
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_field_email{
          txt_field_email.resignFirstResponder()
        }
        return true
    }
    //MARK: - DISMISS KEYBOARD
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
