//
//  RidesDetailViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/12/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit
import AwesomeButton

class RidesDetailViewController: UIViewController {
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var lbl_no_smoking: UILabel!
    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
    }
   
   // @IBOutlet weak var btn_book_this_ride: AwesomeButton!
    @IBOutlet weak var btn_book_this_ride: UIButton!
  
    @IBAction func btn_book_this_ride(_ sender: UIButton) {
         performSegue(withIdentifier: "bookingseat", sender: self)
    }
    
//    @IBAction func btn_book_this_ride(_ sender: AwesomeButton) {
//        performSegue(withIdentifier: "bookingseat", sender: self)
//    }
    @IBOutlet weak var img_view_profile: UIImageView!
    var imageURL: String!
   
    @IBOutlet weak var lbl_no_pets: UILabel!
    @IBOutlet weak var view_view: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       //  setUpScrollView()
        lbl_no_pets.sizeToFit()
        lbl_no_smoking.sizeToFit()
         setUpProfileImage()
        scroll.contentSize.height = 673
        let width1 = self.view.frame.size.width
        scroll.contentSize.width = width1

        
    }
    
    func setUpProfileImage()
    {
        img_view_profile.layer.borderWidth = 1
        img_view_profile.layer.masksToBounds = false
        img_view_profile.layer.borderColor = UIColor.clear.cgColor
        img_view_profile.layer.cornerRadius = img_view_profile.frame.height/2
        
        img_view_profile.clipsToBounds = true
        img_view_profile.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading-icon-1"), options: [.progressiveDownload, .continueInBackground])
    }
    
    func setUpScrollView()
    {
        let screenSize = UIScreen.main.bounds
        
        var scrollView: UIScrollView!
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scrollView.contentSize = CGSize(width: screenWidth, height: 700)
        //scrollView.bounces = false
        //scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
//        scrollView.isUserInteractionEnabled = true
//        scrollView.isExclusiveTouch = true
//        scrollView.canCancelContentTouches = true
//        scrollView.delaysContentTouches = true
        scrollView.addSubview(view_view)
        view.addSubview(scrollView)
     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookingseat"
        {
         let dvc = segue.destination as! BookRideViewController
            dvc.imageURL = imageURL
        }
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
