//
//  SplashViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/26/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
        override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(SplashViewController.readFromShared), with: nil, afterDelay: 3)
         }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
       //MARK: - READ FROM SHARED
    func readFromShared(){
         performSegue(withIdentifier: "splashtologin", sender: self)
    }
   


   

}
