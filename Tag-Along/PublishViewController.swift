//
//  PublishViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/13/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import AwesomeButton
class PublishViewController: UIViewController {
    var isSelected = true
    var titleNavigation: String!
    var buttonLuggage = [UIButton]()
     var stateLuggage = 0
    //MARK : - OUTLETS
    @IBOutlet weak var btn_publish: UIButton!
    @IBAction func btn_publish_ride(_ sender: UIButton) {
        
    }
   
    @IBOutlet weak var btn_medium_outlet: UIButton!
    @IBOutlet weak var btn_large_outlet: UIButton!
    @IBOutlet weak var btn_small_outlet: UIButton!
    

    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
    }
    
    @IBOutlet weak var txt_field_no_of_seats: UITextField!
    @IBAction func btn_subtraction(_ sender: AwesomeButton) {
        var numberOfSeats = Int(txt_field_no_of_seats.text!)
        if numberOfSeats! <= 1{
          
        }
        else{
        numberOfSeats = numberOfSeats! - 1
        txt_field_no_of_seats.text = "\(numberOfSeats!)"
        }
    }
    @IBAction func btn_addition(_ sender: AwesomeButton) {
        var numberOfSeats = Int(txt_field_no_of_seats.text!)
        numberOfSeats = numberOfSeats! + 1
        txt_field_no_of_seats.text = "\(numberOfSeats!)"
    }
    var checked = false
    
    @IBAction func btn_certify(_ sender: UIButton) {
        if checked == false{
            sender.setImage(UIImage(named: "ticked"), for: .normal)
            btn_publish.setTitleColor(UIColor.white, for: .normal)
            checked = true
            btn_publish.isEnabled = true
        }
        else{
            sender.setImage(UIImage(named: "unticked") , for: .normal)
            btn_publish.isEnabled = false
            checked = false
            btn_publish.setTitleColor(UIColor.lightGray, for: .normal)
        }

    }
   
    //MARK : - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleNavigation!
        buttonLuggageType()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    //MARK : - LUGGAGE TYPE
    func buttonLuggageType(){
        btn_large_outlet.addTarget(self, action: #selector(PublishViewController.tappedPublish(_:)), for: .touchUpInside)
        btn_medium_outlet.addTarget(self, action: #selector(PublishViewController.tappedPublish(_:)), for: .touchUpInside)
         btn_small_outlet.addTarget(self, action: #selector(PublishViewController.tappedPublish(_:)), for: .touchUpInside)
        buttonLuggage = [btn_large_outlet, btn_medium_outlet, btn_small_outlet]
    }
    
    //MARK : - TAPPED PUBLISH
    func tappedPublish(_ button: UIButton){
        for (index, buttonClicked) in buttonLuggage.enumerated(){
            if buttonClicked == button{
                buttonClicked.isSelected = true
                print(index)
                stateLuggage = index
            }
            else{
                buttonClicked.isSelected = false
            }
        }
    }
    
    //MARK: - DISMISS KEYBOARD
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
