//
//  OneWayViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/13/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OneWayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var distanceURL = "https://maps.googleapis.com/maps/api/directions/json?"
    var key = "AIzaSyCGvxU5z9nrBmPHK-GPdxyvVufRy9bSCaY"
    var stoppage = [String]()
    var mainStoppageString: String!
    var stoppageString: String!
    var fromAddress: String!
    var toAddress: String!
    var fromLat: Double!
    var fromLng: Double!
    var fromLatLng: String!
    var toLat: Double!
    var toLng: Double!
    var toLatLng: String!
    var fromNewAddress: String!
    var toNewAddress: String!
    var defaultValue: Int!
    var distanceArray = [Double]()
    var withoutStopOverDistance: String!
    
    
    @IBOutlet weak var lbl_total_distance: UILabel!
    @IBOutlet weak var txt_field_to: UITextField!
    @IBOutlet weak var txt_field_time: UITextField!
    @IBOutlet weak var txt_field_date: UITextField!
    @IBAction func btn_next(_ sender: UIButton) {
        performSegue(withIdentifier: "next", sender: self)
    }
    @IBOutlet weak var txt_field_from: UITextField!
    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
    }
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var btn_add_stop: UIButton!
    @IBOutlet weak var txt_field_stopovers: UITextField!
    @IBAction func btn_add_stopover(_ sender: UIButton) {
        if txt_field_stopovers.text == ""{
          alert(message: "No input values", title: "Alert")
        }
        else{
            if stoppage.contains(txt_field_stopovers.text!){
              alert(message: "Cannot have duplicate value", title: "Alert")
            }
            else{
                if stoppage.count >= 5
                {
                 alert(message: "Cannot add more than 5 stopovers", title: "Alert")
                }
                else{
            stoppage.append(stoppageString!)
            stoppageString = ""
            table_view.reloadData()
            txt_field_stopovers.text = ""
            btn_add_stop.isEnabled = false
            var mainStoppageString1 = stoppage[0]
                
                    if self.stoppage.count == 0{
                        print("stoppage = 0")
                        
                    }
                    else
                    {
                        
                        for (index , element) in self.stoppage.enumerated(){
                            if index == 0{
                            
                            }
                            else {
                              mainStoppageString1 = mainStoppageString1 + "|" + element
                            }
                        }
                        print("stoppage address is: \(mainStoppageString1)")
                       
                        DispatchQueue.main.async {
                        let newURL = "origin=" + self.fromNewAddress! + "&destination=" + self.toNewAddress! + "&waypoints=" + mainStoppageString1 + "&key=" + self.key
                            if self.verifyUrl(urlString: self.distanceURL + newURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
                            {
                                let url = self.distanceURL + newURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                             self.callAlamo(url: url, i: "fdsfds")
                                self.startSpinner()
                            }
                            else{
                               print("url not verified")
                            }
                           
                        print("url is: \(newURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))")
                        
                    }
                }
                 print("new stoppage address is: \(mainStoppageString1.replacingOccurrences(of: " ", with: "%20"))")
               // mainStoppageString = mainStoppageString1
            }
        }
        }
    }
    
    @IBOutlet var view_two: UIView!
    @IBOutlet var view_one: UIView!
    func setTextFieldDelegate()
    {
        txt_field_from.delegate = self
        txt_field_to.delegate = self
        txt_field_price.delegate = self
        txt_field_time.delegate = self
        txt_field_stopovers.delegate = self
        txt_field_date.delegate = self
    }
    // MARK: - VIEW CONTROLLER LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
           setTextFieldDelegate()
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        table_view.tableHeaderView = view_one
        table_view.tableFooterView = view_two
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromNotification(name: "notifyOneWayFromName", value: 1)
        getDataFromNotification(name: "notifyOneWayToName", value: 2)
        getDataFromNotification(name: "notifyOneWayFromLatitude", value: 3)
        getDataFromNotification(name: "notifyOneWayFromLongitude", value: 4)
        getDataFromNotification(name: "notifyOneWayFromAddress", value: 5)
        getDataFromNotification(name: "notifyOneWayToAddress", value: 6)
        getDataFromNotification(name: "notifyOneWayToLatitude", value: 7)
        getDataFromNotification(name: "notifyOneWayToLongitude", value: 8)
       // getDataFromNotification(name: "notifyOneWayStopOverOneName", value: 9)
        getDataFromNotification(name: "notifyOneWayStopOverOneAddress", value: 10)
        if self.txt_field_to.text != "" && self.txt_field_from.text != ""
        {
            
            
            
            if self.stoppage.count > 0{
//                print("inside if")
//                let newURL = self.distanceURL + "origin=" + self.fromNewAddress! + "&destination=" + self.toNewAddress! + "&waypoints=" + self.mainStoppageString + "&key=" + self.key
//                
//                self.callAlamo(url: newURL.replacingOccurrences(of: " ", with: "%20"), i: "fdsfds")
//                self.startSpinner()
                
            }
            else{
                print("inside else")
                print("new url is the ")
                print(self.distanceURL)
                print(self.fromNewAddress)
                print(self.toNewAddress)
                print(self.key)
                let newURL = self.distanceURL + "origin=" + self.fromNewAddress! + "&destination=" + self.toNewAddress! + "&key=" + self.key
                
                
                
                self.callAlamo(url: newURL.replacingOccurrences(of: " ", with: "%20"))
                print("url is: \(newURL.replacingOccurrences(of: " ", with: "%20"))")
                self.startSpinner()
                
            }
        }
        else{
            print("inside outer else")
        }

        

        
    }
    //MARK: - GET DATA FROM NOTIFICATION
    func getDataFromNotification(name: String, value: Int)  {
        
        NotificationCenter.default.addObserver(forName: Notification.Name(name), object: nil, queue: nil){ notfication in
            print("notification is: \(notfication)")
            if value == 1{
                self.fromAddress = notfication.object as! String!
                self.txt_field_from.text = self.fromAddress
                print("from address: \(self.fromAddress!)")
                

            }
                
            else if value == 2
            {
                self.toAddress = notfication.object as! String!
                self.txt_field_to.text = self.toAddress
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
            else if value == 9
            {
                self.fromAddress = notfication.object as! String!
                print("from address: \(self.fromAddress!)")
            }
            else if value == 10
            {
                self.stoppageString = notfication.object as! String!
                self.txt_field_stopovers.text = self.stoppageString
                self.btn_add_stop.isEnabled = true
            }
            else {
              print("fdsfds")
            }
            
            

            
        }
        
    }

    // MARK: - PREPARE FOR SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "next"
        {
           let dvc = segue.destination as! PublishViewController
            dvc.titleNavigation = "ONE WAY TRIP"
        }
        else if segue.identifier == "autocomplete"
        {
            
          let dvc = segue.destination as! AutoCompleteNewViewController
            dvc.defaultValues = self.defaultValue
        }
    }
    // MARK: - TEXTFIELD DELEGATE METHODS
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txt_field_stopovers{
           //btn_add_stop.isEnabled = true
            if txt_field_from.text == "" && txt_field_to.text == ""{
              alert(message: "No source and destination ", title: "Alert")
                return false
            }
            else {
            self.defaultValue = 5
            performSegue(withIdentifier: "autocomplete", sender: self)
            return false
            }
            
        }
        else if textField == txt_field_from{
            self.defaultValue = 3
            performSegue(withIdentifier: "autocomplete", sender: self)
            return false
        }
        else if textField == txt_field_to{
            self.defaultValue = 4
            performSegue(withIdentifier: "autocomplete", sender: self)
            return false
        }
        else if textField == txt_field_date{
            let datePicker = UIDatePicker()
            datePicker.backgroundColor = UIColor.white
            
            datePicker.datePickerMode = UIDatePickerMode.date
            
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
            return true

        }
        else if textField == txt_field_time{
            let datePicker = UIDatePicker()
            datePicker.backgroundColor = UIColor.white
            
            datePicker.datePickerMode = UIDatePickerMode.time
            
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(timePickerChanged(sender:)), for: .valueChanged)
            return true
        }
                else
        {
         return true
        }
    }
    @IBOutlet weak var txt_field_price: UITextField!
    func timePickerChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        txt_field_time.text = formatter.string(from: sender.date)
    }
    
    func datePickerChanged(sender: UIDatePicker)
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        txt_field_date.text = formatter.string(from: sender.date)
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyBoard()
    }
    func closeKeyBoard(){
        self.view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        btn_add_stop.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_field_stopovers{
            btn_add_stop.isEnabled = false
            txt_field_stopovers.resignFirstResponder()
        }
     
        else if textField == txt_field_date{
         txt_field_date.resignFirstResponder()
        }
        else if textField == txt_field_time{
         txt_field_time.resignFirstResponder()
        }
        else if textField == txt_field_price
        {
          txt_field_price.resignFirstResponder()
        }
        return true
    }
   
    // MARK: - ALERTS METHODS
    func alert(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - TABLEVIEW DELEGATES
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stoppage.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StopOverTableViewCell
        cell.lbl_stopover.text = stoppage[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            stoppage.remove(at: indexPath.row)
           distanceArray.removeAll()
            table_view.reloadData()
            print(stoppage)
           
            var totalDistance = 0.0
            if stoppage.count == 0{
              
                let newURL = self.distanceURL + "origin=" + self.fromNewAddress! + "&destination=" + self.toNewAddress! + "&key=" + self.key
                
                
                
                self.callAlamo(url: newURL.replacingOccurrences(of: " ", with: "%20"))
                print("url is: \(newURL.replacingOccurrences(of: " ", with: "%20"))")
                self.startSpinner()
            }
            else{
                 var mainStoppageString1 = stoppage[0]
                for (index , element) in self.stoppage.enumerated(){
                    if index == 0{
                        
                    }
                    else {
                        mainStoppageString1 = mainStoppageString1 + "|" + element
                    }
                }
                print("stoppage address is: \(mainStoppageString1)")
                
                DispatchQueue.main.async {
                    let newURL = "origin=" + self.fromNewAddress! + "&destination=" + self.toNewAddress! + "&waypoints=" + mainStoppageString1 + "&key=" + self.key
                    if self.verifyUrl(urlString: self.distanceURL + newURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
                    {
                        let url = self.distanceURL + newURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                        self.callAlamo(url: url, i: "fdsfds")
                        self.startSpinner()
                    }
                    else{
                        print("url not verified")
                    }
                    
                    print("url is: \(newURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))")
                    
                }
            
            }

            
           
           
            
            
        }
    }
    //MARK: - DISMISS KEYBOARD
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    //MARK: - CALLING WEBSERVICE ALOMO
    //stoppage webservice
    func callAlamo(url: String, i: String){
        view.isUserInteractionEnabled = false
        //let params: Parameters = ["type": "find_ride", "searchdate": searchDate, "From": from, "To": to]
        
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            print("response is: \(response)")
            self.parseData(JSONData: response.data!, i: "feds")
            //self.parseData(JSONData: response)
        })

    }
    //from and to webservice
    func callAlamo(url: String)
    {
        view.isUserInteractionEnabled = false
        //let params: Parameters = ["type": "find_ride", "searchdate": searchDate, "From": from, "To": to]
        
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            print("response is: \(response)")
            self.parseData(JSONData: response.data!)
            //self.parseData(JSONData: response)
        })
        
        
    }
    // stoppage webservice
    func parseData(JSONData: Data, i: String){
        let json = JSON(Data: JSONData)
        print("json is: \(json)")
        view.isUserInteractionEnabled = true
        stopSpinner()
        
        
      
        if let routes = json["routes"].arrayObject{
            print("new json \(routes)")
            if let legs = json["routes"][0]["legs"].arrayObject
            {
                print("legs count is: \(legs.count)")
                for index in 0...legs.count - 1{
                  if let distance = json["routes"][0]["legs"][index]["distance"].dictionary
                  {
                    for (key, value) in distance {
                        print("\(key) -> \(value)")
                        if key == "text"
                        {
                          print("real distance is: \(value)")
                            
                            var main: String!
                            var main1: String!
                            
                            main1 = "\(value)"
                            if main1!.contains(",") && main1!.contains(" mi")
                            {
                                 main = main1!.replacingOccurrences(of: ",", with: "")
                                 main1 = main.replacingOccurrences(of: " mi", with: "")
                            }
                            else if main1!.contains(" mi"){
                             main1 = main1!.replacingOccurrences(of: " mi", with: "")
                            }
                            
                            if let main2 = Double(main1!) {
                                distanceArray.append(main2)
                                
                            }
                        }
                    }
                  }
                }
              }
        }
        var totalDistance = 0.0
        if distanceArray.count == 0{
            
        }
        else{
            for index in 0...distanceArray.count - 1{
                totalDistance = totalDistance + distanceArray[index]
                print("total distance is: \(totalDistance)")
            }
            self.lbl_total_distance.text = "\(totalDistance) mi"
        }
 
    }

    // from and to webservice
    func parseData(JSONData: Data){
        let json = JSON(Data: JSONData)
        print("json is: \(json)")
        view.isUserInteractionEnabled = true
        stopSpinner()
        var newDistance: String!
        if let routes = json["routes"].arrayObject{
          print("new json \(routes)")
            if let legs = json["routes"][0]["legs"].arrayObject
            {
              print("legs is: \(legs)")
                if let distance = json["routes"][0]["legs"][0]["distance"].dictionary
                {
                    print("distance is: \(distance)")
                    for (key, value) in distance {
                        print("\(key) -> \(value)")
                        if key == "text"
                        {
                          print("real distance is: \(value)")
                          
                            self.lbl_total_distance.text = "\(value)"
                          
                            
                        }
                        
                    }
                }
            }
            
        }
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
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            UIApplication.shared.open(url, options: [:], completionHandler: {
                (success) in
                print("Open \(scheme): \(success)")
            })
        }
    }
    //MARK: - VALIDATE URL
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = URL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    

}
