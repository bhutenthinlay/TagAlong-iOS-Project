//
//  AutoCompleteNewViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/29/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import GooglePlaces
protocol LocationDetailProtocol {
    func sendAddress(address: String)
}

class AutoCompleteNewViewController: UIViewController, GMSAutocompleteResultsViewControllerDelegate{
    var protocolLocation: LocationDetailProtocol!
    var defaultValues: Int!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?

    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);

    }
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
                // Do something with the selected place.
                print("Place name: \(place.name)")
                print("Place address: \(place.formattedAddress)")
                print("Place attributions: \(place.attributions)")
                print(self.defaultValues)
                if self.defaultValues! == 1{
                    NotificationCenter.default.post(name: Notification.Name("notifyFromName"), object: place.name)
                    NotificationCenter.default.post(name: Notification.Name("notifyFromAddress"), object: place.formattedAddress)
                    print("plate latitute and longitute is : \(place.coordinate.latitude), \(place.coordinate.longitude)")
                    NotificationCenter.default.post(name: Notification.Name("notifyFromLatitude"), object: place.coordinate.latitude)
                    NotificationCenter.default.post(name: Notification.Name("notifyFromLongitude"), object: place.coordinate.longitude)
                 //   self.protocolLocation.sendAddress(address: place.name)
                    let when = DispatchTime.now() + 0.4 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        // Your code with delay
                        if let navController = self.navigationController {
                            print("inside")
                            navController.popViewController(animated: true)
                            
                        }

                    }
                    
                }
                else if self.defaultValues! == 2
                {
                    NotificationCenter.default.post(name: Notification.Name("notifyToName"), object: place.name)
                    NotificationCenter.default.post(name: Notification.Name("notifyToAddress"), object: place.formattedAddress)
                    NotificationCenter.default.post(name: Notification.Name("notifyToLatitude"), object: place.coordinate.latitude)
                    NotificationCenter.default.post(name: Notification.Name("notifyToLongitude"), object: place.coordinate.longitude)
                  //  self.protocolLocation.sendAddress(address: place.name)
                    let when = DispatchTime.now() + 0.4 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        // Your code with delay
                        if let navController = self.navigationController {
                            print("inside")
                            navController.popViewController(animated: true)
                            
                        }
                        
                    }

              
                }
                    //for one way from
                else if self.defaultValues! == 3
                {
                    NotificationCenter.default.post(name: Notification.Name("notifyOneWayFromName"), object: place.name)
                    NotificationCenter.default.post(name: Notification.Name("notifyOneWayFromAddress"), object: place.formattedAddress)
                    NotificationCenter.default.post(name: Notification.Name("notifyOneWayFromLatitude"), object: place.coordinate.latitude)
                    NotificationCenter.default.post(name: Notification.Name("notifyOneWayFromLongitude"), object: place.coordinate.longitude)
                    //  self.protocolLocation.sendAddress(address: place.name)
                    let when = DispatchTime.now() + 0.4 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        // Your code with delay
                        if let navController = self.navigationController {
                            print("inside")
                            navController.popViewController(animated: true)
                            
                        }
                        
                    }
                }
                    //for one way to
                else if self.defaultValues! == 4
                {
                    NotificationCenter.default.post(name: Notification.Name("notifyOneWayToName"), object: place.name)
                    NotificationCenter.default.post(name: Notification.Name("notifyOneWayToAddress"), object: place.formattedAddress)
                    NotificationCenter.default.post(name: Notification.Name("notifyOneWayToLatitude"), object: place.coordinate.latitude)
                    NotificationCenter.default.post(name: Notification.Name("notifyOneWayToLongitude"), object: place.coordinate.longitude)
                    //  self.protocolLocation.sendAddress(address: place.name)
                    let when = DispatchTime.now() + 0.4 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        // Your code with delay
                        if let navController = self.navigationController {
                            print("inside")
                            navController.popViewController(animated: true)
                            
                        }
                        
                    }
        }
                else if self.defaultValues! == 5
                {
                    NotificationCenter.default.post(name: Notification.Name("notifyOneWayStopOverOneName"), object: place.name)
                    NotificationCenter.default.post(name: Notification.Name("notifyOneWayStopOverOneAddress"), object: place.formattedAddress)
                   
                    //  self.protocolLocation.sendAddress(address: place.name)
                    let when = DispatchTime.now() + 0.4 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        // Your code with delay
                        if let navController = self.navigationController {
                            print("inside")
                            navController.popViewController(animated: true)
                            
                        }
                        
                    }
        }
        


       
//                self.navigationController?.popViewController(animated: true)
//                
//                self.dismiss(animated: true, completion: nil)
                //Dismiss Search
        
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
          print("Error: ", error.localizedDescription)
    }
    // Turn the network activity indicator on and off again.
        func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    
        func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsViewController = GMSAutocompleteResultsViewController()
        let filter = GMSAutocompleteFilter()
        filter.country = "USA"
        resultsViewController?.autocompleteFilter = filter
        resultsViewController?.delegate = self
        
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
              // Put the search bar in the navigation bar.
        searchController?.searchBar.sizeToFit()
        searchController?.searchBar.tintColor = UIColor.gray
        navigationItem.titleView = searchController?.searchBar
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // searchController?.isActive = true  // doubtful whether this is needed
        
        DispatchQueue.main.async {
            self.searchController?.searchBar.becomeFirstResponder()
        }
    }
}

