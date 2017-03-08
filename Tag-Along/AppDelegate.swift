//
//  AppDelegate.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/8/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import GooglePlaces
import SlideMenuControllerSwift
import Firebase
import CoreData
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    fileprivate func createMenuView(value: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeNewViewController") as! HomeNewViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.mainViewController = nvc
        let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        if value == true
        {
            self.window?.rootViewController = slideMenuController
            self.window?.makeKeyAndVisible()
        }
        else {
            self.window?.rootViewController = firstViewController
            self.window?.makeKeyAndVisible()
        }
    }
    func updateViewController(value: Bool){
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        self.createMenuView(value: value)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        GMSPlacesClient.provideAPIKey("AIzaSyDkmZZo99UkPbJvERT-JHNcOPGs6mjuMac")
         FIRApp.configure()
        if readFromShared(){
            updateViewController(value: true)

        }
        else{
           updateViewController(value: false)
        }
                return true
    }
    //MARK: - READ FROM SHARED
    func readFromShared() -> Bool{
        let preferences = UserDefaults.standard
        // startSpinner()
        let key = "memberID"
        
        if preferences.object(forKey: key) == nil {
            print("nothing saved splash")
            return false
           
        } else {
           
            let nameNew = preferences.object(forKey: key)
            let memberID = nameNew as! String!
            print("Member id is: \(memberID!)")
            return true
          
        }
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        
       
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
       self.saveContext()
    }
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SlideMenuNew")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

   }

