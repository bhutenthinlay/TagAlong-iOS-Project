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
   
    var defaultNewValue: Int!
    var segmentioStyle = SegmentioStyle.OnlyLabel
    var content = [SegmentioItem]()
    let findARide = SegmentioItem(title: "FIND A RIDE", image: UIImage(named: "fb"))
    let offerARide = SegmentioItem(title: "OFFER A RIDE", image: UIImage(named: "fb"))
    var fromAddress: String!
    var rideDetail = RidesDetails()
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
                NotificationCenter.default.post(name: Notification.Name("segment0"), object: 0)
                break
            case 1:
                print("1")
                NotificationCenter.default.post(name: Notification.Name("segment1"), object: 1)
                
                break
            default: break
            }
        
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("currentindexafter"), object: nil, queue: nil){ notfication in
            print("notification is: \(notfication.object as! Int)")
            self.view_segmentio.selectedSegmentioIndex = notfication.object as! Int
        }
        NotificationCenter.default.addObserver(forName: Notification.Name("currentindexbefore"), object: nil, queue: nil){ notfication in
            print("notification is: \(notfication.object as! Int)")
            self.view_segmentio.selectedSegmentioIndex = notfication.object as! Int
        }
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
//        swipeRight.direction = UISwipeGestureRecognizerDirection.right
//        self.view.addGestureRecognizer(swipeRight)
      
        
    }
//    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
//            switch swipeGesture.direction {
//            case UISwipeGestureRecognizerDirection.right:
//                print("Swiped right")
//            case UISwipeGestureRecognizerDirection.down:
//                print("Swiped down")
//            case UISwipeGestureRecognizerDirection.left:
//                print("Swiped left")
//            case UISwipeGestureRecognizerDirection.up:
//                print("Swiped up")
//            default:
//                break
//            }
//        }
//    }
    
    func segueToNext(identifier: String, defaultValue: Int) {
        self.defaultNewValue = defaultValue

        self.performSegue(withIdentifier: identifier, sender: self)
              print("Default value is: \(defaultNewValue)")
        
    }
       func segueToNext(identifier: String, defaultValue: Int, ridesDetail: RidesDetails) {
        self.rideDetail = ridesDetail
       
        performSegue(withIdentifier: identifier, sender: self)
        
    }
    func clearAllData()
    {
        rideDetail.driverName.removeAll()
        rideDetail.driverDepartureFrom.removeAll()
        rideDetail.driverDestinationTo.removeAll()
        rideDetail.driverDepartureTime.removeAll()
        rideDetail.driverDepartureDate.removeAll()
        rideDetail.driverImageURL.removeAll()
        rideDetail.driverRating.removeAll()
        rideDetail.driverPrice.removeAll()
        
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
            dvc.ridesDetail = rideDetail
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
            let dvc = segue.destination as! AutoCompleteNewViewController
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
        clearAllData()
               // Do any additional setup after loading the view.
        

    }

}

protocol SegueHandler: class {
    func segueToNext(identifier: String, defaultValue: Int)
      func segueToNext(identifier: String, defaultValue: Int, ridesDetail: RidesDetails)
    
}
