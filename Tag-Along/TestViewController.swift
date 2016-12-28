//
//  TestViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/18/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var scroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.contentSize.height = 670
        let width1 = self.view.frame.size.width
        scroll.contentSize.width = width1
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
