//
//  HomeNewViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 1/17/17.
//  Copyright © 2017 Tenzin Thinlay. All rights reserved.
//

import UIKit
import Segmentio
import SlideMenuControllerSwift
class HomeNewViewController: UIViewController, SlideMenuControllerDelegate {
    
    @IBAction func bar_btn_message(_ sender: UIBarButtonItem) {
//        let chatController = ChatListViewController()
//        self.navigationController?.pushViewController(chatController, animated: true)
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatListViewController") as? ChatListViewController {
            //            viewController.newsObj = newsObj
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }

    }
    @IBAction func bar_btn_menu(_ sender: UIBarButtonItem) {
        self.slideMenuController()?.toggleLeft()
    }
    var defaultNewValue: Int!
    var segmentioStyle = SegmentioStyle.OnlyLabel
    var content = [SegmentioItem]()
    let findARide = SegmentioItem(title: "FIND A RIDE", image: UIImage(named: "fb"))
    let offerARide = SegmentioItem(title: "OFFER A RIDE", image: UIImage(named: "fb"))
    var fromAddress: String!
    var rideDetail = RidesDetails()
    
    @IBOutlet weak var view_segmentio: Segmentio!
    override func viewDidLoad() {
        super.viewDidLoad()
        content.append(findARide)
        content.append(offerARide)
        setUpSegmentio()
       //self.setNavigationBarItem()
        customizeNavigationbar()
     
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


        // Do any additional setup after loading the view.
    }
    // MARK: - Customize Navigation Bar
    func customizeNavigationbar()
    {
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()

        navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.08, green:0.2, blue:0.38, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.08, green:0.2, blue:0.38, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //  self.navigationItem.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
       
    }

    // MARK: - set up segmentio (Tab bar)
    func setUpSegmentio()
    {
        view_segmentio.setup(content: content, style: segmentioStyle, options: SegmentioOptions())
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }


}
extension UIViewController {
    
    func setNavigationBarItem() {
        //        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        //        self.addRightBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    func removeNavigationBarItem() {
        //        self.navigationItem.leftBarButtonItem = nil
        //        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
}

