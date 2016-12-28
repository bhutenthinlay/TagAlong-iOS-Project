//
//  OneWayViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/13/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class OneWayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var stoppage = [String]()
    
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
        
        }
        else{
            if stoppage.contains(txt_field_stopovers.text!){
              print("duplicate")
                alert(message: "Cannot have duplicate value", title: "Alert")
            }
            else{
            stoppage.append(txt_field_stopovers.text!)
        table_view.reloadData()
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
        override func viewDidLoad() {
        super.viewDidLoad()
           setTextFieldDelegate()
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        table_view.tableHeaderView = view_one
        table_view.tableFooterView = view_two
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"
        {
           let dvc = segue.destination as! PublishViewController
            dvc.titleNavigation = "ONE WAY TRIP"
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txt_field_stopovers{
        btn_add_stop.isEnabled = true
            return true
        }
        else if textField == txt_field_from{
            performSegue(withIdentifier: "autocomplete", sender: self)
            return false
        }
        else if textField == txt_field_to{
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
    func alert(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 69
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 350
//    }

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
            table_view.reloadData()
        }
    }
    //MARK: - DISMISS KEYBOARD
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
