//
//  EditeProfileVC.swift
//  iOSApp
//
//  Created by Ahmed kamal on 8/30/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

class EditeProfileVC: UIViewController {

    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnUploadImage: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = Helper.getaUser_name()
        email.text = Helper.getauser_Email()
        
        if Helper.getaUser_id() == nil  {
                  
            name.isHidden = true
            email.isHidden = true
            password.isHidden = true
            img.isHidden = true
            btnUploadImage.isHidden = true
            btnUpdate.isHidden = true
           
            showAlertWithTitle(title: "Error", message: "Please login First", type: .error )
              } else {
                 
                print("welcome")
              }
          
          
        
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
   
    @IBAction func uploadImgeAction(_ sender: Any) {
       
                     let actionSheet = UIAlertController(title : nil, message : nil, preferredStyle : .actionSheet)
                                actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert : UIAlertAction!) in
                                    self.camera()
                                }))
                                
                                
                                actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert : UIAlertAction!) in
                                    self.photoLibrary()
                                }))
                                
                                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                                
                                self.present(actionSheet, animated: true, completion: nil)
                 }
                 
           
    func camera()
         {
             if UIImagePickerController.isSourceTypeAvailable(.camera)
             {
                 let myPickerController = UIImagePickerController()
                 myPickerController.delegate = self;
                 myPickerController.sourceType = .camera
                 self.present(myPickerController, animated : true, completion : nil)
                 
             }
             else
             {
                 let alert = UIAlertController(title: "Error", message: "camera not available", preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                 alert.addAction(okAction)
                 self.present(alert, animated: true, completion: nil)
                 
                 print("camera not available")
             }
         }
         func photoLibrary()
         {
             if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
             {
                 let myPickerController = UIImagePickerController()
                 myPickerController.delegate = self;
                 myPickerController.sourceType = .photoLibrary
                 self.present(myPickerController, animated : true, completion : nil)
                 
             }
         }
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

          // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard (info[.originalImage] as? UIImage) != nil else {
              fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
          }

          // Set photoImageView to display the selected image.
          
        
        
          // Dismiss the picker.
          dismiss(animated: true, completion: nil)
      }
      
    
    @IBAction func updateProfileAction(_ sender: Any) {
       

                 EditeProfile()
              
            }
    }
    



extension EditeProfileVC {
    
     func EditeProfile(){
            
            view.lock()
                
                      let param = [
            
                        "name" : "\(name.text!)",
                        "email" : "\(email.text!)",
                        "password" : "\(password.text!)",
                      
            ]
                       
                    print(param)
        
            ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)update_profile") { (data : EdoiteProfileModel?, String) in
                                                                 
                     self.view.unlock()
                      
                    //  self.AdsCollectionVoew.showLoader()
                    
                          if String != nil {
                                               
                             self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                         
                               }else {
                                                                  
                                guard let data = data else {
                                     return
                                     }
                                  print(data)
                          
                            Helper.Saveuser_namen(name: self.name?.text)
                            Helper.Saveuser_Email(email: self.email.text)
                           // Helper.Saveuser_Image(image: "\(self.img!.image)")
                            
                                    appscene.SideMenu()
                                    self.showStatus(image: #imageLiteral(resourceName: "true"), message: "Successfully")
                                        }
                                                           
                                                           
                                 }
                
            
            
        }
    
          
    
}

