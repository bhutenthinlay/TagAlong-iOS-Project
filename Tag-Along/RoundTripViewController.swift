//
//  RoundTripViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/13/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class RoundTripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

   //MARK: - OUTLETS
    @IBOutlet weak var txt_field_price: UITextField!
    @IBOutlet weak var txt_field_return_time: UITextField!
    @IBOutlet weak var txt_field_return_date: UITextField!
    @IBOutlet weak var txt_field_departure_time: UITextField!
    @IBOutlet weak var txt_field_departure_date: UITextField!
    @IBOutlet weak var txt_field_to: UITextField!
    @IBOutlet weak var txt_field_from: UITextField!
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
    }
       @IBOutlet var view3: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view1: UIView!
    @IBOutlet weak var table_view: UITableView!
    var newFromStopover = [String]()
    var fromStopover = [String]()
    var toStopover = [String]()
    
    @IBOutlet weak var txt_field_return_stopover: UITextField!
    @IBAction func btn_add_departure_stopover(_ sender: UIButton) {
        fromStopover.append(txt_field_departure_stopover.text!)
        table_view.reloadData()
    }
    @IBAction func btn_add_return_stopover(_ sender: UIButton) {
        toStopover.append(txt_field_return_stopover.text!)
        table_view.reloadData()
    }
   
    @IBOutlet weak var txt_field_departure_stopover: UITextField!
    
    @IBAction func btn_next(_ sender: UIButton) {
     performSegue(withIdentifier: "roundtripnext", sender: self)
    }
    //MARK: - PREPARE FOR SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "roundtripnext"{
          let dvc = segue.destination as! PublishViewController
            dvc.titleNavigation = "ROUND TRIP"
        }
    }
    //MARK: - SET UP TEXTFIELD DELEGATE
    func setUpTextFieldDelegate(){
     txt_field_to.delegate = self
        txt_field_from.delegate = self
        txt_field_price.delegate = self
        txt_field_departure_date.delegate = self
        txt_field_departure_time.delegate = self
        txt_field_departure_stopover.delegate = self
        txt_field_return_stopover.delegate = self
        txt_field_return_date.delegate = self
        txt_field_return_time.delegate = self
        txt_field_to.delegate = self
    }
    //MARK: -VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextFieldDelegate()
        txt_field_to.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
//MARK: - TABLEVIEW DELEGATE METHOD
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
         return fromStopover.count
        }
        else{
          return toStopover.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell0") as! RoundTripFromTableViewCell
          cell.lbl_from.text = fromStopover[indexPath.row]
        
        return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! RoundTripToTableViewCell
            cell.lbl_to.text = toStopover[indexPath.row]
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return view1
        }
        else {
         return nil
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0{
         return view2
        }
        else{
           return view3
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0
        {
        return 63
        }
        else{
          return 0.1
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
         return 148
        }
        else{
         return 325
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            if indexPath.section == 0{
             fromStopover.remove(at: indexPath.row)
                table_view.reloadData()
            }
            else{
           
            toStopover.remove(at: indexPath.row)
            
                table_view.reloadData()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: - DISMISS KEYBOARD
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}
