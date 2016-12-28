//
//  MyRideViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/14/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import Segmentio
class MyRideViewController: UIViewController {
    @IBOutlet weak var container_view_as_a_driver: UIView!
    @IBOutlet weak var container_view_as_a_booker: UIView!
    var segmentioStyle = SegmentioStyle.OnlyLabel
    var content = [SegmentioItem]()
    let findARide = SegmentioItem(title: "AS A DRIVER", image: UIImage(named: "fb"))
    let offerARide = SegmentioItem(title: "AS A BOOKER", image: UIImage(named: "fb"))
    
    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        
    }
    var segmentioIndex: Int!
    @IBOutlet weak var view_segmentio: Segmentio!
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationbar()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        content.append(findARide)
        content.append(offerARide)
        setUpSegmentio()
        print("index: \(segmentioIndex!)")
        if segmentioIndex == 0{
            self.container_view_as_a_booker.isHidden = true
            self.container_view_as_a_driver.isHidden = false
        }
        else if segmentioIndex == 1{
            self.container_view_as_a_booker.isHidden = false
            self.container_view_as_a_driver.isHidden = true
        }
        
        view_segmentio.selectedSegmentioIndex = segmentioIndex!
        view_segmentio.valueDidChange = { segmentio, segmentIndex in
            //print("Selected item: ", segmentIndex)
            switch (segmentIndex){
            case 0:
                print(segmentIndex)
                 self.container_view_as_a_booker.isHidden = true
                self.container_view_as_a_driver.isHidden = false
               
//                self.containerview_findaride.isHidden = false
//                self.containerview_offeraride.isHidden = true
                break
            case 1:
                print(segmentIndex)
                self.container_view_as_a_booker.isHidden = false
                self.container_view_as_a_driver.isHidden = true
//                self.containerview_findaride.isHidden = true
//                self.containerview_offeraride.isHidden = false
                
                break
            default: break
            }
            
        }

        
        // Do any additional setup after loading the view.
    }
    // MARK: - SETUP SEGMENTIO(TAB BAR)
    
    func setUpSegmentio()
    {
        view_segmentio.setup(content: content, style: segmentioStyle, options: SegmentioOptions())
        
    }
    // MARK: - CUSTOMIZE NAVIGATIONBAR
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
