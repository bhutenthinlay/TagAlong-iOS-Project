//
//  PaymentNewViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/19/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class PaymentNewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFCardDelegate {
    var actualAmount: Double!
    var actualAmountDecimal: Double!
    var cardname: UITextField!
    var cardNumber: UITextField!
    var cardExpDate: UITextField!
    var cardCVV: UITextField!
    var cardType: UIImageView!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! NewCardTableViewCell
           let preferences = UserDefaults.standard
            cell.lbl_actual_amount.text = "\(Int(actualAmount!))"
           // cell.lbl_acutal_amount_decimal.text = ".\(actualAmount)".replacingOccurrences(of: "0.", with: "")
            cell.btn_add_card.addTarget(self, action:#selector(PaymentNewViewController.addCard(button:)), for: .touchUpInside)
            if preferences.object(forKey: "cardtype") == nil {
                print("nothing saved")
            } else {
                let nameNew = preferences.object(forKey: "cardtype") as! String!
                if nameNew == "Visa"
                {
                    cell.img_view_card.image = UIImage(named: "Visa")
                }
                else if nameNew == "UnionPay"
                {
                    cell.img_view_card.image = UIImage(named: "UnionPay")

                }
                else if nameNew == "MasterCard"
                {
                    cell.img_view_card.image = UIImage(named: "MasterCard")
                    
                }
                else if nameNew == "JCB"
                {
                    cell.img_view_card.image = UIImage(named: "JCB")
                    
                }
                else if nameNew == "Dinners Club"
                {
                    cell.img_view_card.image = UIImage(named: "DinnersClub")
                    
                }
                else if nameNew == "Discover"
                {
                    cell.img_view_card.image = UIImage(named: "Discover")
                    
                }
                else if nameNew == "Amex"
                {
                    cell.img_view_card.image = UIImage(named: "Amex")
                    
                }
                else if nameNew == "Maestro"
                {
                    cell.img_view_card.image = UIImage(named: "Maestro")
                    
                }
                else if nameNew == "Electron"
                {
                    cell.img_view_card.image = UIImage(named: "Electron")
                
                }
                else if nameNew == "Dankort"
                {
                    cell.img_view_card.image = UIImage(named: "Dankort")
                    
                }
                else if nameNew == "RuPay"
                {
                    cell.img_view_card.image = UIImage(named: "RuPay")
                    
                }
                else if nameNew == "Unknown"
                {
                    cell.img_view_card.image = UIImage(named: "Unknown")
                    
                }
            }
            cardType = cell.img_view_card
            if preferences.object(forKey: "cardtype") == nil {
                print("nothing saved")
            } else
            {
                let nameNew = preferences.object(forKey: "cardtype")
                
                cardType.image = UIImage(named: nameNew as! String!)
            }
            cardname = cell.txt_field_card_name
            
            if preferences.object(forKey: "cardname") == nil {
                print("nothing saved")
            } else {
                let nameNew = preferences.object(forKey: "cardname")
               
                    cardname.text = nameNew as! String!
            }
            cardNumber = cell.txt_field_card_number
            if preferences.object(forKey: "cardnumber") == nil {
                print("nothing saved")
            } else {
                let nameNew = preferences.object(forKey: "cardnumber")
                
                cardNumber.text = nameNew as! String!
            }

            cardExpDate = cell.txt_field_card_exp_date
            if preferences.object(forKey: "cardexpdate") == nil {
                print("nothing saved")
            } else {
                let nameNew = preferences.object(forKey: "cardexpdate")
                
                cardExpDate.text = nameNew as! String!
            }

            cardCVV = cell.txt_field_card_cvv
            if preferences.object(forKey: "cardcvv") == nil {
                print("nothing saved")
            } else {
                let nameNew = preferences.object(forKey: "cardcvv")
                
                cardCVV.text = nameNew as! String!
            }

         return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! PaypalTableViewCell
            return cell

        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
          return 261
        }
        else{
         return 159
        }
    }
    func addCard(button: UIButton)
    {
        var myCard : MFCardView
        myCard  = MFCardView(withViewController: self)
        myCard.delegate = self
        myCard.autoDismiss = true
        myCard.toast = true
        myCard.showCard()
    }
    func cardDoneButtonClicked(_ card: Card?, error: String?) {
        if error == nil{
            print("card detail is: \(card!)")
            print((card?.name!)!)
            print((card?.number!)!)
            print((card?.month!)! + "-" + (card?.year!)!)
            print((card?.cvc!)!)
            print((card?.cardType!)!.rawValue)
            writeShared(key: "cardname", value: (card?.name!)!)
            writeShared(key: "cardnumber", value: (card?.number!)!)
            writeShared(key: "cardexpdate", value: (card?.month!)! + "/" + (card?.year!)!)
            writeShared(key: "cardcvv", value: (card?.cvc!)!)
            writeShared(key: "cardtype", value: (card?.cardType!)!.rawValue)
            readAndSetSharedValues()
            
        }else
        {
            print(error!)
        }

    }
    func cardTypeDidIdentify(_ cardType: String) {
         print(cardType)
    }
    //MARK: - READ AND SET SAHRED VALUE
    func readAndSetSharedValues()
    {
        readFromShared(key: "cardname")
        readFromShared(key: "cardnumber")
        readFromShared(key: "cardexpdate")
        readFromShared(key: "cardcvv")
        readFromShared(key: "cardtype")
    }
    //MARK: -  WRITE ON SHARED PREFERENCE
    func writeShared(key: String, value: String)
    {
        let preferences = UserDefaults.standard
        
        let key = key
        
        let value = value
        // preferences.setInteger(value, forKey: key)
        preferences.set(value, forKey: key)
        
        
        //  Save to disk
        let didSave = preferences.synchronize()
        
        if !didSave {
            //  Couldn't save (I've never seen this happen in real world testing)
        }
        
    }
    //MARK: - READ FROM SHARED
    func readFromShared(key: String){
        let preferences = UserDefaults.standard
        
        
        if preferences.object(forKey: key) == nil {
            print("nothing saved")
        } else {
            //  let currentLevel = preferences.integer(forKey: currentLevelKey)
            let nameNew = preferences.object(forKey: key)
            if key == "cardname"
            {
              cardname.text = nameNew as! String!
            }
            else if key == "cardnumber"
            {
              cardNumber.text = nameNew as! String!
            }
            else if key == "cardexpdate"
            {
               cardExpDate.text = nameNew as! String!
            }
            else if key == "cardcvv"
            {
              cardCVV.text = nameNew as! String!
            }
            else if key == "cardtype"
            {
                cardType.image = UIImage(named: nameNew as! String!)
            }
            
        }
    }
}
