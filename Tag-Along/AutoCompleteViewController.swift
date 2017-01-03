//
//  AutoCompleteViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/16/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import GooglePlacesSearchController

class AutoCompleteViewController: UIViewController{
    var protocolLocation: LocationDetailProtocol!
    let GoogleMapsAPIServerKey = "AIzaSyDIjJPQQ4yqsPSg3VxSOMo8ZRESkeXKCwQ"
    var defaultValues: Int!

    @IBOutlet weak var btn_search: UIBarButtonItem!
    @IBAction func bar_btn_search(_ sender: UIBarButtonItem) {
        let controller = GooglePlacesSearchController(
            apiKey: GoogleMapsAPIServerKey,
            placeType: PlaceType.address
        )
        
        //        Or if you want to use autocompletion for specific coordinate and radius (in meters)
        //        let coord = CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423)
        //        let controller = GooglePlacesSearchController(
        //            apiKey: GoogleMapsAPIServerKey,
        //            placeType: PlaceType.Address,
        //            coordinate: coord,
        //            radius: 10
        //        )
        
        controller.didSelectGooglePlace { (place) -> Void in
            print(place.description)
            print("\(place.name) : \(place.formattedAddress) : \(place.coordinate.latitude) : \(place.coordinate.longitude)")
            print(self.defaultValues)
            if self.defaultValues! == 1{
                NotificationCenter.default.post(name: Notification.Name("notifyFromName"), object: place.name)
                NotificationCenter.default.post(name: Notification.Name("notifyFromAddress"), object: place.formattedAddress)
                NotificationCenter.default.post(name: Notification.Name("notifyFromLatitude"), object: place.coordinate.latitude)
                NotificationCenter.default.post(name: Notification.Name("notifyFromLongitude"), object: place.coordinate.longitude)
                self.protocolLocation.sendAddress(address: place.name)
                //  print(place.description)
            }
            else if self.defaultValues! == 2
            {
                NotificationCenter.default.post(name: Notification.Name("notifyToName"), object: place.name)
                NotificationCenter.default.post(name: Notification.Name("notifyToAddress"), object: place.formattedAddress)
                NotificationCenter.default.post(name: Notification.Name("notifyToLatitude"), object: place.coordinate.latitude)
                NotificationCenter.default.post(name: Notification.Name("notifyToLongitude"), object: place.coordinate.longitude)
                self.protocolLocation.sendAddress(address: place.name)
                
            }

            self.navigationController?.popViewController(animated: true)
            
            self.dismiss(animated: true, completion: nil)
            //Dismiss Search
            controller.isActive = false
        }
        
        present(controller, animated: true, completion: nil)

    }
    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        let controller = GooglePlacesSearchController(
            apiKey: GoogleMapsAPIServerKey,
            placeType: PlaceType.address
        )
        
        //        Or if you want to use autocompletion for specific coordinate and radius (in meters)
        //        let coord = CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423)
        //        let controller = GooglePlacesSearchController(
        //            apiKey: GoogleMapsAPIServerKey,
        //            placeType: PlaceType.Address,
        //            coordinate: coord,
        //            radius: 10
        //        )
        
        controller.didSelectGooglePlace { (place) -> Void in
            print(place.description)
            print("\(place.name) : \(place.formattedAddress) : \(place.coordinate.latitude) : \(place.coordinate.longitude)")
            print(self.defaultValues)
            if self.defaultValues! == 1{
             NotificationCenter.default.post(name: Notification.Name("notifyFromName"), object: place.name)
            NotificationCenter.default.post(name: Notification.Name("notifyFromAddress"), object: place.formattedAddress)
           NotificationCenter.default.post(name: Notification.Name("notifyFromLatitude"), object: place.coordinate.latitude)
            NotificationCenter.default.post(name: Notification.Name("notifyFromLongitude"), object: place.coordinate.longitude)
            self.protocolLocation.sendAddress(address: place.name)
          //  print(place.description)
            }
            else if self.defaultValues! == 2
            {
                NotificationCenter.default.post(name: Notification.Name("notifyToName"), object: place.name)
                NotificationCenter.default.post(name: Notification.Name("notifyToAddress"), object: place.formattedAddress)
                NotificationCenter.default.post(name: Notification.Name("notifyToLatitude"), object: place.coordinate.latitude)
                NotificationCenter.default.post(name: Notification.Name("notifyToLongitude"), object: place.coordinate.longitude)
                self.protocolLocation.sendAddress(address: place.name)

            }
            self.navigationController?.popViewController(animated: true)
            
            self.dismiss(animated: true, completion: nil)

            //Dismiss Search
            controller.isActive = false
        }
        
        present(controller, animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }
    //MARK: - DISMISS KEYBOARD
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

   
}
