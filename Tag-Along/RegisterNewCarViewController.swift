//
//  RegisterNewCarViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 1/24/17.
//  Copyright © 2017 Tenzin Thinlay. All rights reserved.
//

import UIKit
import AwesomeButton

class RegisterNewCarViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBAction func bar_btn_message(_ sender: UIBarButtonItem) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatListViewController") as? ChatListViewController {
            //            viewController.newsObj = newsObj
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    @IBAction func btn_add_new_car(_ sender: AwesomeButton) {
    }
    @IBOutlet weak var txt_field_car_type: UITextField!
    @IBOutlet weak var txt_field_car_color: UITextField!
    @IBOutlet weak var txt_field_number_of_seat: UITextField!
    @IBOutlet weak var txt_field_car_comfort: UITextField!
    @IBOutlet weak var txt_field_car_model: UITextField!
    @IBOutlet weak var txt_field_car_make: UITextField!
    @IBOutlet weak var txt_field_car_name: UITextField!
    @IBOutlet weak var img_view_car: UIImageView!
    @IBAction func bar_btn_back(_ sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapImageButton(_:)))
        img_view_car.isUserInteractionEnabled = true
        img_view_car.addGestureRecognizer(tapGesture)
        makeRoundedImage()

        // Do any additional setup after loading the view.
    }
    func makeRoundedImage(){
        img_view_car.layer.borderWidth = 1
        img_view_car.layer.borderColor = UIColor.clear.cgColor
       img_view_car.layer.cornerRadius = img_view_car.frame.height/2
    }
    func tapImageButton(_ sender: UITapGestureRecognizer){

        let myActionSheet = UIAlertController(title: "Picture Selection", message: "Please select you image from following", preferredStyle: UIAlertControllerStyle.actionSheet)
        let camera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default){
            (ACTION) in
            print("camera")
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerControllerSourceType.camera
            image.allowsEditing = true
            self.present(image, animated: true, completion: nil)
        }
        let photoGallery = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default){
            (ACTION) in
            print("Gallery")
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerControllerSourceType.photoLibrary
            image.allowsEditing = true
            self.present(image, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default){
            (ACTION) in
            print("Cancel")
        }
        myActionSheet.addAction(camera)
        myActionSheet.addAction(photoGallery)
        myActionSheet.addAction(cancel)
        self.present(myActionSheet, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image  = info[UIImagePickerControllerOriginalImage] as? UIImage{
          img_view_car.image = image
        }
        else{
          print("There was an error with importing image")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
