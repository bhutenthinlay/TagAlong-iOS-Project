//
//  UIApplication.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 1/18/17.
//  Copyright © 2017 Tenzin Thinlay. All rights reserved.
//


import UIKit
import SlideMenuControllerSwift
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
