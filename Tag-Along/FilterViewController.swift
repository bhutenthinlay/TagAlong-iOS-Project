//
//  FilterViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/14/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AwesomeButton
protocol MyProtocol {
    func reloadTableViewData(array: [String])
    func reloadTableViewData(ridesDetail: RidesDetails)
   
}
class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
     var filterValues = [String]()
    // MARK: - OUTLETS AND DECLARATION
    
    @IBOutlet weak var btn_rating_all: UIButton!
    @IBOutlet weak var btn_rating_three: UIButton!
    @IBOutlet weak var btn_rating_four: UIButton!
    @IBOutlet weak var btn_rating_five: UIButton!
    @IBOutlet weak var btn_ride_type_ladies: UIButton!
    @IBOutlet weak var btn_ride_type_shopping: UIButton!
    @IBOutlet weak var btn_rating_two: UIButton!
    @IBOutlet weak var btn_rating_one: UIButton!
    @IBOutlet weak var btn_luxury_car: UIButton!
    @IBOutlet weak var btn_comfort_car: UIButton!
    @IBOutlet weak var btn_basic_car: UIButton!
    @IBOutlet weak var btn_all_car: UIButton!
    @IBOutlet weak var btn_with_picture_only: UIButton!
    @IBOutlet weak var btn_all_picture: UIButton!
    @IBOutlet var view_price: UIView!
    @IBOutlet weak var btn_all_price: UIButton!
    @IBOutlet weak var btn_average_price: UIButton!
    @IBOutlet weak var lbl_range_max: UILabel!
    @IBOutlet weak var lbl_range_min: UILabel!
    @IBOutlet weak var rang_slider_time: RangeSlider!
    @IBOutlet weak var btn_low_price: UIButton!
    @IBOutlet weak var btn_high_price: UIButton!
    @IBOutlet var view_rating: UIView!
    @IBOutlet var view_car_comfort: UIView!
    @IBOutlet var view_ride_type: UIView!
    @IBOutlet var view_pictures: UIView!
    @IBOutlet var view_time: UIView!
    @IBOutlet weak var view_base: UIView!
    @IBOutlet weak var table_view: UITableView!
    var stateTimeLower = 0
    var stateTimeHigher = 24
    var statePrice = "All"
    var statePicture = "Allphoto"
    var stateCarComfort = "All"
    var stateRating = "All"
    var stateRidetype = "Yes"
    var buttonsPrice = [UIButton]()
    var buttonsPicture = [UIButton]()
    var buttonsCarcomfort = [UIButton]()
    var buttonsrating = [UIButton]()
    var lowerValueRange = 0
    var upperValueRange = 24
    var array1 = [String]()
    var array2 = [String]()
    var myprotocol: MyProtocol?
    var buttonPriceArray = ["All", "High", "Average", "Low"]
    var buttonPictureArray = ["Allphoto", "Photo"]
    var buttonRidetypeArray = ["Yes", "Shopping"]
    var buttonCarComfortArray = ["All", "Basic", "Comfortable", "Luxury"]
    var buttonRatingArray = ["All", "One", "Two", "Three", "Four", "Five"]
    var ridesDetail = RidesDetails()
     var searchURL = "https://tag-along.net/webservice.php"
    var searchDate: String!
    
    // MARK:- VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
      
        array2 = ["fdsfdsfdd", "fdfdsfdsfdssfds", "fdsfds"]
        filterValues = ["Time", "Price", "Pictures", "Ride Type", "Car Comfort", "Rating"]
        let index = NSIndexPath(row: 0, section: 0)
        //UITableViewScrollPosition = .middle
        table_view.selectRow(at: index as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
        view_base.addSubview(view_time)
        buttonPrice()
        buttonPicture()
        buttonCarComfort()
        buttonRating()
        buttonRideType()
        // Do any additional setup after loading the view.
        rang_slider_time.lowerValue = Double(lowerValueRange)
        rang_slider_time.upperValue = Double(upperValueRange)
        rang_slider_time.addTarget(self, action: #selector(FilterViewController.rangeSliderValueChanged(_:)), for: .valueChanged)
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

    //MARK:- SETUP BE FILTER BUTTONS
    func buttonRideType(){
        btn_ride_type_ladies.isSelected = false
        btn_ride_type_shopping.isSelected = false
         btn_ride_type_ladies.addTarget(self, action: #selector(FilterViewController.tappedRide(_:)), for: .touchUpInside)
          btn_ride_type_shopping.addTarget(self, action: #selector(FilterViewController.tappedRide(_:)), for: .touchUpInside)
    }
    func tappedRide(_ button: UIButton){
        if button == btn_ride_type_ladies{
          if button.isSelected == true{
            stateRidetype = ""
                      print(stateRidetype)
                      button.isSelected = false
                    }
                    else{
            
            stateRidetype = "Yes"
                      button.isSelected = true
                      print(stateRidetype)
                    }
            
        }
        else if button == btn_ride_type_shopping{
            if button.isSelected == true{
               stateRidetype = "Yes"
                button.isSelected = false
                print(stateRidetype)
            }
            else{
                button.isSelected = true
                 stateRidetype = stateRidetype + "," + "Shopping"
                
                print(stateRidetype)
                
            }
        }
    }
    func buttonRating(){
         btn_rating_all.addTarget(self, action: #selector(FilterViewController.tappedRating(_:)), for: .touchUpInside)
        btn_rating_one.addTarget(self, action: #selector(FilterViewController.tappedRating(_:)), for: .touchUpInside)
         btn_rating_two.addTarget(self, action: #selector(FilterViewController.tappedRating(_:)), for: .touchUpInside)
         btn_rating_three.addTarget(self, action: #selector(FilterViewController.tappedRating(_:)), for: .touchUpInside)
         btn_rating_four.addTarget(self, action: #selector(FilterViewController.tappedRating(_:)), for: .touchUpInside)
         btn_rating_five.addTarget(self, action: #selector(FilterViewController.tappedRating(_:)), for: .touchUpInside)
        
       
        
        buttonsrating = [btn_rating_all, btn_rating_one, btn_rating_two, btn_rating_three, btn_rating_four, btn_rating_five]
        buttonsrating[0].isSelected = true

    }
    func tappedRating(_ button: UIButton){
        for (index, buttonClicked) in buttonsrating.enumerated(){
            if buttonClicked == button{
                buttonClicked.isSelected = true
                print(index)
                if index == 0{
                 stateRating = "All"
                }
                else if index == 1{
                  stateRating = "1"
                }
                else if index == 2{
                    stateRating = "2"
                }
                else if index == 3{
                    stateRating = "3"
                }
                else if index == 4{
                    stateRating = "4"
                }
                else if index == 5{
                    stateRating = "5"
                }
//                stateRating = buttonRatingArray[index]
//                print(stateRating)
                
                        
            }
            else{
                buttonClicked.isSelected = false
                
                
            }
            
        }
        
    }

    func buttonCarComfort(){
        btn_all_car.addTarget(self, action: #selector(FilterViewController.tappedCar(_:)), for: .touchUpInside)
        
        btn_basic_car.addTarget(self, action: #selector(FilterViewController.tappedCar(_:)), for: .touchUpInside)
        btn_comfort_car.addTarget(self, action: #selector(FilterViewController.tappedCar(_:)), for: .touchUpInside)
        btn_luxury_car.addTarget(self, action: #selector(FilterViewController.tappedCar(_:)), for: .touchUpInside)
        
        buttonsCarcomfort = [btn_all_car, btn_basic_car, btn_comfort_car, btn_luxury_car]
        buttonsCarcomfort[0].isSelected = true

    }
    func tappedCar(_ button: UIButton){
        for (index, buttonClicked) in buttonsCarcomfort.enumerated(){
            if buttonClicked == button{
                buttonClicked.isSelected = true
                print(index)
                stateCarComfort = buttonCarComfortArray[index]
                
                
                
            }
            else{
                buttonClicked.isSelected = false
                
                
            }
            
        }

    }
    func buttonPicture(){
        btn_all_picture.addTarget(self, action: #selector(FilterViewController.tappedPicture(_:)), for: .touchUpInside)
        
        btn_with_picture_only.addTarget(self, action: #selector(FilterViewController.tappedPicture(_:)), for: .touchUpInside)
      
        buttonsPicture = [btn_all_picture, btn_with_picture_only]
        buttonsPicture[0].isSelected = true
    }
    func buttonPrice(){
        btn_all_price.addTarget(self, action: #selector(FilterViewController.tappedPrice(_:)), for: .touchUpInside)
        
        btn_high_price.addTarget(self, action: #selector(FilterViewController.tappedPrice(_:)), for: .touchUpInside)
        btn_average_price.addTarget(self, action: #selector(FilterViewController.tappedPrice(_:)), for: .touchUpInside)
        btn_low_price.addTarget(self, action: #selector(FilterViewController.tappedPrice(_:)), for: .touchUpInside)
        buttonsPrice = [btn_all_price, btn_high_price, btn_average_price, btn_low_price]
        buttonsPrice[0].isSelected = true
    }
   
    
    func rangeSliderValueChanged(_ rangeSlider: RangeSlider)
    {
       lbl_range_min.text = "\(Int(rangeSlider.lowerValue / 1))h"
        lowerValueRange = Int(rangeSlider.lowerValue)
        stateTimeLower = lowerValueRange
        lbl_range_max.text = "\(Int(rangeSlider.upperValue / 1))h"
        upperValueRange = Int(rangeSlider.upperValue)
        stateTimeHigher = upperValueRange
        
         print("Range slider value changed: (\(rangeSlider.lowerValue / 1) , \(rangeSlider.upperValue / 1))")
    }
    func tappedPicture(_ button: UIButton){
        for (index, buttonClicked) in buttonsPicture.enumerated(){
            if buttonClicked == button{
                buttonClicked.isSelected = true
                print(index)
                statePicture = buttonPictureArray[index]
            }
            else{
                buttonClicked.isSelected = false
            }
        }
    }
    func tappedPrice(_ button: UIButton)
    {
      //button.isSelected = state
         for (index, buttonClicked) in buttonsPrice.enumerated(){
              if buttonClicked == button{
                  buttonClicked.isSelected = true
                  print(buttonPriceArray[index])
                  statePrice = buttonPriceArray[index]
                }
                else{
                    buttonClicked.isSelected = false
                }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         let index = NSIndexPath(row: 0, section: 0)
        let cell = table_view.cellForRow(at: index as IndexPath) as! FileterValueTableViewCell
        cell.lbl_filter_value.textColor = UIColor.red
    }
    func tappedSubmit(_ button: AwesomeButton){
        DispatchQueue.main.async {
            self.callAlamo(url: self.searchURL, searchDate: self.ridesDetail.driverDate, from: "(" + self.ridesDetail.driverFromLatLng + ")", to: "(" + self.ridesDetail.driverToLatLng + ")")
            self.startSpinner()
        }
        
      //MARK: - IMPORTANT PROTOCOL

    }
    //MARK: - CALLING WEBSERVICE ALOMO
    func callAlamo(url: String, searchDate: String, from: String, to: String)
    {
        view.isUserInteractionEnabled = false
        //let params: Parameters = ["type": "find_ride", "searchdate": searchDate, "From": from, "To": to]
        let params: Parameters = ["type": "find_ride", "searchdate": searchDate, "From_lat_long": from, "To_lat_long": to, "price": "Medium", "search": "place", "memrating": stateRating, "fromhr": stateTimeLower, "tohr": stateTimeHigher, "ridetype[]": stateRidetype, "carcomfort": stateCarComfort, "fltimg": statePicture, "ePriceType": statePrice]
        
        Alamofire.request(url, method: .post, parameters: params).responseJSON(completionHandler: {
            response in
            print("response is: \(response)")
            self.parseData(JSONData: response.data!)
            //self.parseData(JSONData: response)
        })
        
        
    }
    func parseData(JSONData: Data){
        let json = JSON(Data: JSONData)
        print("json from filter is: \(json)")
        view.isUserInteractionEnabled = true
        stopSpinner()
        if let mainarray = json["mainarr"].arrayObject{
            //            if mainarray == "No result found"
            //            {
            //
            //            }
            
            //            else {
            if mainarray.count > 0{
                clearAllData()
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
                       
                        ridesDetail.driverName.append(name)
                        print("driver name from model \(ridesDetail.driverName[i])")
                       
                    }
                    if let from = json["mainarr"][i]["from"].string {
                       
                        ridesDetail.driverDepartureFrom.append(from)
                        
                    }
                    if let to = json["mainarr"][i]["to"].string {
                       
                        ridesDetail.driverDestinationTo.append(to)
                    }
                    if let image = json["mainarr"][i]["image"].string {
                       
                        ridesDetail.driverImageURL.append(image)
                        
                    }
                    if let price = json["mainarr"][i]["price"].string {
                       
                        ridesDetail.driverPrice.append(price)
                        
                        
                    }
                    if let rating = json["mainarr"][i]["rating"].int {
                      
                        ridesDetail.driverRating.append(rating)
                    }
                    if let date = json["mainarr"][i]["start_date"].string {
                       
                        ridesDetail.driverDepartureDate.append(date)
                       
                    }
                    if let time = json["mainarr"][i]["start_time"].string {
                        
                        ridesDetail.driverDepartureTime.append(time)
                       
                    }
                    if let schedule = json["mainarr"][i]["flexibility"].string{
                        ridesDetail.driverSchedule.append(schedule)
                    }
                    if let detour = json["mainarr"][i]["detour"].string{
                        ridesDetail.driverDetour.append(detour)
                    }
                    if let luggage = json["mainarr"][i]["Luggage"].string{
                        ridesDetail.driverLuggageSize.append(luggage)
                    }
                    if let seat = json["mainarr"][i]["seats"].string{
                        ridesDetail.driverSeatAvailable.append(seat)
                    }
                    if let carName = json["mainarr"][i]["carname"].string{
                        ridesDetail.driverCarBrand.append(carName)
                    }
                    if let carComfort = json["mainarr"][i]["carcomfort"].string{
                        ridesDetail.driverCarComfort.append(carComfort)
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                //  delegate?.segueToNext(identifier: "ridesavailable", defaultValue: 3, driverName: driverName, driverFrom: driverFrom, driverTo: driverTo, driverImageURL: driverImageURL, driverPrice: driverPrice, driverRating: driverRating, driverStartDate: driverStartDate, driverStartTime: driverStartTime)
                //delegate?.segueToNext(identifier: "ridesavailable", defaultValue: 3, ridesDetail: ridesDetail)
                
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
                        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
               // myprotocol?.reloadTableViewData(array: array2)
                myprotocol?.reloadTableViewData(ridesDetail: ridesDetail)
                
                
              //  performSegue(withIdentifier: "rideavailable", sender: self)
            //    clearAllData()
                
                
            }
            
        }
        else if let mainarray = json["mainarr"].string
        {
            if mainarray == "No result found"
            {
                print("Error no value")
               performSegue(withIdentifier: "cantfindride", sender: self)
               // delegate?.segueToNext(identifier: "cantfindride", defaultValue: 4)
            }
        }
        
        
        
    }
    //MARK: -CLEAR ALL DATA
    func clearAllData()
    {
        ridesDetail.driverName.removeAll()
        ridesDetail.driverDepartureFrom.removeAll()
        ridesDetail.driverDestinationTo.removeAll()
        ridesDetail.driverImageURL.removeAll()
        
        ridesDetail.driverPrice.removeAll()
        ridesDetail.driverRating.removeAll()
        ridesDetail.driverDepartureTime.removeAll()
        ridesDetail.driverDepartureDate.removeAll()    }
   // MARK: - TABLEVIEW DELEGATES
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterValues.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == filterValues.count{
        let cell = tableView.dequeueReusableCell(withIdentifier: "button") as! FilterSubmitButtonTableViewCell
            cell.btn_submit.addTarget(self, action: #selector(FilterViewController.tappedSubmit(_:)), for: .touchUpInside)
            
            return cell
        }
        else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FileterValueTableViewCell
            cell.lbl_filter_value.text = filterValues[indexPath.row]
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == filterValues.count
        {
         return 139
        }
        else{
         return 72
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 0 && indexPath.row <= 5{
            let cell = tableView.cellForRow(at: indexPath) as! FileterValueTableViewCell
            cell.lbl_filter_value.textColor = UIColor.red
            cell.backgroundColor = UIColor.white
            if indexPath.row == 0
            {
                view_base.addSubview(view_time)
            }
            else if indexPath.row == 1{
                view_base.addSubview(view_price)
            }
            else if indexPath.row == 2{
                view_base.addSubview(view_pictures)
            }
            else if indexPath.row == 3{
                view_base.addSubview(view_ride_type)
            }
            else if indexPath.row == 4{
                view_base.addSubview(view_car_comfort)
            }
            else if indexPath.row == 5{
                view_base.addSubview(view_rating)
            }
        }
        if indexPath.row == 6{
          table_view.deselectRow(at: indexPath, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FileterValueTableViewCell
        cell.lbl_filter_value.textColor = UIColor.lightGray
    }
    
}
