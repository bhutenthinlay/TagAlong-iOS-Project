//
//  FindARideViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/8/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import AwesomeButton
import Alamofire
import SwiftyJSON
class FindARideViewController: UIViewController, UITextFieldDelegate{
    weak var delegate: SegueHandler?
    var flag = false
    var number: Int!
    var searchDate: String!
    var fromAddress: String!
    var fromNewAddress: String!
    var toAddress: String!
    var toNewAddress: String!
    var fromLat: Double!
    var fromLng: Double!
    var fromLatLng: String!
    var toLatLng: String!
    var toLat: Double!
    var toLng: Double!
    var driverName = [String]()
    var driverPrice = [String]()
    var driverFrom = [String]()
    var driverTo = [String]()
    var driverImageURL = [String]()
    var driverRating = [Int]()
    var driverStartDate = [String]()
    var driverStartTime = [String]()
    typealias  JSONstandard = [String: AnyObject]
    var searchURL = "https://tag-along.net/webservice.php"
    @IBOutlet weak var btn_to: UIButton!
    @IBOutlet weak var btn_from: UIButton!
    @IBOutlet weak var txt_field_date: UITextField!
    
    @IBAction func btn_to(_ sender: UIButton) {
        delegate?.segueToNext(identifier: "autocomplete", defaultValue: 1)
    }
    
    @IBAction func btn_from(_ sender: UIButton) {
        delegate?.segueToNext(identifier: "autocomplete", defaultValue: 2)
    }
   
       @IBAction func btn_search(_ sender: AwesomeButton) {
        if btn_from.currentTitle == "From"{
          alert(alert: "Alert", message: "Please enter a address")
        }
        else if btn_to.currentTitle == "To"{
          alert(alert: "Alert", message: "Please enter a address")
        }
        else if txt_field_date.text == ""{
         alert(alert: "Alert", message: "Please enter a date")
        }
        else{
        if flag == false{
            print(searchURL)
            print(fromNewAddress!)
            print(toNewAddress!)
            
            print(fromLatLng!)
            print(toLatLng!)
            DispatchQueue.main.async {
                self.callAlamo(url: self.searchURL, searchDate: self.searchDate!, from: "(" + self.fromLatLng! + ")", to: "(" + self.toLatLng! + ")", fromLatLong: self.fromLatLng!, toLatLong: self.toLatLng!)
                self.startSpinner()
            }
            
            //delegate?.segueToNext(identifier: "ridesavailable", defaultValue: 3)
          
            
        }
        else{
            delegate?.segueToNext(identifier: "cantfindride", defaultValue: 4)
        }
        }
        
    }
   //    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == txt_field_from{
//            delegate?.segueToNext(identifier: "autocomplete")
//        }
//        else{
//            delegate?.segueToNext(identifier: "autocomplete")
//        }
//    }
    
    //MARK: - VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_field_date.attributedPlaceholder = NSAttributedString(string: "Select a Date", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        print("num: \(number)")
        print("find a ride : \(fromAddress)")
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("hi from view will apppear")

        getDataFromNotification(name: "notifyFromName", value: 1)
        if let _ = fromAddress{
          self.btn_from.setTitle(self.fromAddress!, for: .normal)
        }
       
        
        getDataFromNotification(name: "notifyToName", value: 2)
        if let _ = toAddress{
            self.btn_to.setTitle(self.toAddress!, for: .normal)
        }
        getDataFromNotification(name: "notifyFromLatitude", value: 3)
        getDataFromNotification(name: "notifyFromLongitude", value: 4)
         getDataFromNotification(name: "notifyFromAddress", value: 5)
        
        getDataFromNotification(name: "notifyToAddress", value: 6)
        getDataFromNotification(name: "notifyToLatitude", value: 7)
        getDataFromNotification(name: "notifyToLongitude", value: 8)
        
        
    


    }
    //MARK: - STOP SPINNER
    func stopSpinner(){
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true);
        
    }
    
    
    //MARK: - START SPINNER
    func startSpinner()
    {
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        
        spinnerActivity.label.text = "Loading";
        
        spinnerActivity.detailsLabel.text = "Please Wait!!";
        
        spinnerActivity.isUserInteractionEnabled = false;
        
    }
    
    //MARK: - CALLING WEBSERVICE ALOMO
    func callAlamo(url: String, searchDate: String, from: String, to: String, fromLatLong: String, toLatLong: String)
    {
        view.isUserInteractionEnabled = false
        //let params: Parameters = ["type": "find_ride", "searchdate": searchDate, "From": from, "To": to]
        let params: Parameters = ["type": "find_ride", "searchdate": searchDate, "From_lat_long": from, "To_lat_long": to]

        Alamofire.request(url, method: .post, parameters: params).responseJSON(completionHandler: {
            response in
            print("response is: \(response)")
            self.parseData(JSONData: response.data!)
            //self.parseData(JSONData: response)
        })
        
        
    }
    func parseData(JSONData: Data){
        let json = JSON(Data: JSONData)
        print("json is: \(json)")
        view.isUserInteractionEnabled = true
        stopSpinner()
        if let mainarray = json["mainarr"].arrayObject{
//            if mainarray == "No result found"
//            {
//            
//            }
            
//            else {
            if mainarray.count > 0{
                var name = String()
                for i in 0..<mainarray.count{
                if let firstName = json["mainarr"][i]["FirstName"].string {
                    print("userName is : \(firstName)")
                    name = firstName
                    //driverName.append(userName)
                 }
                if let lastName = json["mainarr"][i]["LastName"].string {
                        print("userName is : \(lastName)")
                        name = name + " " + lastName
                        driverName.append(name)
                       print(driverName)
                    }
                    if let from = json["mainarr"][i]["from"].string {
                        driverFrom.append(from)
                        print(driverFrom)
                    }
                    if let to = json["mainarr"][i]["to"].string {
                        driverTo.append(to)
                        print(driverTo)
                    }
                    if let image = json["mainarr"][i]["image"].string {
                        driverImageURL.append(image)
                        print(driverImageURL)
                    }
                    if let price = json["mainarr"][i]["price"].string {
                        driverPrice.append(price)
                        print(driverPrice)
                    }
                    if let rating = json["mainarr"][i]["rating"].int {
                        driverRating.append(rating)
                        print(driverRating)
                    }
                    if let date = json["mainarr"][i]["start_date"].string {
                        driverStartDate.append(date)
                        print(driverStartDate)
                    }
                    if let time = json["mainarr"][i]["start_time"].string {
                        driverStartTime.append(time)
                        print(driverStartTime)
                    }




                    
                    
                }
                delegate?.segueToNext(identifier: "ridesavailable", defaultValue: 3, driverName: driverName, driverFrom: driverFrom, driverTo: driverTo, driverImageURL: driverImageURL, driverPrice: driverPrice, driverRating: driverRating, driverStartDate: driverStartDate, driverStartTime: driverStartTime)
                clearAllData()
               

            }
           
        }
        else if let mainarray = json["mainarr"].string
        {
            if mainarray == "No result found"
            {
             print("Error no value")
             delegate?.segueToNext(identifier: "cantfindride", defaultValue: 4)
            }
        }
        
        
        
    }
    //MARK: -CLEAR ALL DATA
    func clearAllData()
    {
        driverName.removeAll()
        driverFrom.removeAll()
        driverTo.removeAll()
        driverImageURL.removeAll()
        driverPrice.removeAll()
        driverRating.removeAll()
        driverStartTime.removeAll()
        driverStartDate.removeAll()
    }

//MARK: - GET DATA FROM NOTIFICATION
    func getDataFromNotification(name: String, value: Int)  {
      
        NotificationCenter.default.addObserver(forName: Notification.Name(name), object: nil, queue: nil){ notfication in
            print("notification is: \(notfication)")
            if value == 1{
            self.fromAddress = notfication.object as! String!
                print("from address: \(self.fromAddress!)")
            }
            else if value == 2
            {
             self.toAddress = notfication.object as! String!
                print("to address: \(self.toAddress!)")
                
            }
            else if value == 3
            {
             self.fromLat = notfication.object as! Double
                print("latitude is: \(self.fromLng)")
            }
            else if value == 4
            {
             self.fromLng = notfication.object as! Double
                self.fromLatLng = String(format:"%f", self.fromLat) + ", " + String(format:"%f", self.fromLng)
                print("from lat long is: \(self.fromLatLng!)")
                
            }
            else if value == 5
            {
              self.fromNewAddress = notfication.object as! String!
                print("from new address is : \(self.fromNewAddress!)")
            }
            else if value == 6
            {
             self.toNewAddress = notfication.object as! String!
               print("to new address is: \(self.toNewAddress!)")
            }
            else if value == 7
            {
                self.toLat = notfication.object as! Double!
            }
            else if value == 8
            {
                self.toLng = notfication.object as! Double!
                self.toLatLng = String(format:"%f", self.toLat) + ", " + String(format:"%f", self.toLng)
                print("to lat long is: \(self.toLatLng!)")
            }
            
        }
       
    }
//MARK: - TEXTFIELD DELEGATE METHOD
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = UIColor.white
        
        datePicker.datePickerMode = UIDatePickerMode.date
        
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txt_field_date.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyBoard()
    }
    
    
    func closeKeyBoard(){
        self.view.endEditing(true)
    }
// MARK: - DATE PICKER CHANGED
    
    func datePickerChanged(sender: UIDatePicker)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYYY"
         // formatter.dateStyle = .long
        searchDate = formatter.string(from: sender.date)
        txt_field_date.text = formatter.string(from: sender.date)
        view.endEditing(true)

        
    }
    // MARK: - ALERT
    
    func alert(alert: String, message: String)
    {
        let alert = UIAlertController(title: alert, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: - DISMISS KEYBOARD
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
}
