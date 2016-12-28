//
//  HomeViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/8/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import Segmentio

class HomeViewController: UIViewController, SegueHandler, LocationDetailProtocol{
    var driverName = [String]()
    var driverPrice = [String]()
    var driverFrom = [String]()
    var driverTo = [String]()
    var driverImageURL = [String]()
    var driverRating = [Int]()
    var driverStartDate = [String]()
    var driverStartTime = [String]()
    let loginDetail = LoginDetails()
    var defaultNewValue: Int!
    var segmentioStyle = SegmentioStyle.OnlyLabel
    var content = [SegmentioItem]()
    let findARide = SegmentioItem(title: "FIND A RIDE", image: UIImage(named: "fb"))
    let offerARide = SegmentioItem(title: "OFFER A RIDE", image: UIImage(named: "fb"))
    var fromAddress: String!
    // MARK: - Outlets
    @IBOutlet weak var bar_btn_menu: UIBarButtonItem!
  
    @IBOutlet weak var containerview_offeraride: UIView!
    @IBOutlet weak var containerview_findaride: UIView!
    @IBOutlet weak var view_segmentio: Segmentio!
    // MARK: - GET DATA FROM SHARED PREFERENCE
    func readFromShared(){
     let preferences = UserDefaults.standard
    
    let currentLevelKey = "memberID"
    
    if preferences.object(forKey: currentLevelKey) == nil {
     print("nothing saved")
    } else {
  //  let currentLevel = preferences.integer(forKey: currentLevelKey)
        let memberID = preferences.object(forKey: currentLevelKey)
        print("Member id is: \(memberID)")
     }
    }

    // MARK: - View life cycle methods
       override func viewDidLoad() {
        super.viewDidLoad()
        print("email from model at home is: \(loginDetail.email)")
      
        bar_btn_menu.target = self.revealViewController()
        bar_btn_menu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        customizeNavigationbar()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        content.append(findARide)
        content.append(offerARide)
        setUpSegmentio()
        view_segmentio.selectedSegmentioIndex = 0
        view_segmentio.valueDidChange = { segmentio, segmentIndex in
            //print("Selected item: ", segmentIndex)
            switch (segmentIndex){
            case 0:
                print("Selected one")
                self.containerview_findaride.isHidden = false
                self.containerview_offeraride.isHidden = true
                break
            case 1:
                print("1")
                self.containerview_findaride.isHidden = true
                self.containerview_offeraride.isHidden = false
                
                break
            default: break
            }
            
        }
      
        
    }
    func segueToNext(identifier: String, defaultValue: Int) {
        self.defaultNewValue = defaultValue

        self.performSegue(withIdentifier: identifier, sender: self)
              print("Default value is: \(defaultNewValue)")
        
    }
    func segueToNext(identifier: String, defaultValue: Int, driverName: [String], driverFrom: [String], driverTo: [String], driverImageURL: [String], driverPrice: [String], driverRating: [Int], driverStartDate: [String], driverStartTime: [String]) {
        self.defaultNewValue = defaultValue
        self.driverName = driverName
        self.driverFrom = driverFrom
        self.driverTo = driverTo
        self.driverImageURL = driverImageURL
        self.driverPrice = driverPrice
        self.driverRating = driverRating
        self.driverStartDate = driverStartDate
        self.driverStartTime = driverStartTime
        self.performSegue(withIdentifier: identifier, sender: self)
        //clearAllData()
        
        
    }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "embeded" {
            let dvc = segue.destination as! FindARideViewController
            dvc.delegate = self
            dvc.number = 1
            dvc.fromAddress = fromAddress
            
            
        }
        else if segue.identifier == "ridesavailable"{
          let dvc = segue.destination as! RidesAvailableViewController
            
            dvc.destination = driverTo
            dvc.departureFrom = driverFrom
            dvc.starRating = driverRating
            dvc.name = driverName
            dvc.time = driverStartTime
            dvc.date = driverStartDate
            dvc.price = driverPrice
            dvc.imageURL = driverImageURL
           
        }
    
        else if segue.identifier == "offeraride" {
            let dvc = segue.destination as! OfferARideViewController
            dvc.delegate = self
            
            
        }
        else if segue.identifier == "cantfindride"{
          print("to can't find ride")
        }
        else if segue.identifier == "autocomplete"
        {
            
           let dvc = segue.destination as! AutoCompleteViewController
            dvc.protocolLocation = self
           dvc.defaultValues = defaultNewValue
        }
        
    }
   
    // MARK: - Customize Navigation Bar
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
     // MARK: - set up segmentio (Tab bar)
    func setUpSegmentio()
    {
        view_segmentio.setup(content: content, style: segmentioStyle, options: SegmentioOptions())
       
    }
     func sendAddress(address: String)
     {
       print("got the address in home: \(address)")
        fromAddress = address
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        readFromShared()
               // Do any additional setup after loading the view.
        

    }

}

protocol SegueHandler: class {
    func segueToNext(identifier: String, defaultValue: Int)
    func segueToNext(identifier: String, defaultValue: Int, driverName: [String], driverFrom: [String], driverTo: [String], driverImageURL: [String], driverPrice: [String], driverRating: [Int], driverStartDate: [String], driverStartTime: [String])
    
}
