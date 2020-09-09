//
//  LoginVC.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var lblName: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnregister(_ sender: Any) {       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let vc  = storyboard.instantiateViewController(withIdentifier: "RegisterVC")
          navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnforgetPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 let vc  = storyboard.instantiateViewController(withIdentifier: "ForgetPasswordVC")
                 navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func skipAction(_ sender: Any) {
        appscene.SideMenu()
    }
    
    @IBAction func btnLogin(_ sender: Any) {
       
        
        if isNotEmptyString(text: lblName.text!, withAlertMessage: "Please insert your name") , isNotEmptyString(text: lblPassword.text!, withAlertMessage: "Please insert password") {

           login()
        }
     }
}
   

extension LoginVC {
    
    
     func login(){
            
            view.lock()
                
                      let param = [
            
                      
                        "email" : "\(lblName.text!)",
                        "password" : "\(lblPassword.text!)",
                        
                        
                        
            ]
                       
        print(param)
        
            ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)login") { (data : LoginModel?, String) in
                                                                 
                                                                 self.view.unlock()
                      
                    //  self.AdsCollectionVoew.showLoader()
                    
                          
                                                                if String != nil {
                                               
                                                                   self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                         
                                                                }else {
                                                                  
                                                                  guard let data = data else {
                                                                      return
                                                                  }
                                                                  print(data)
                                                                  
                                                                    appscene.SideMenu()
                                                                
                                                            Helper.Saveuser_namen(name: data.data?.name)
                                                            Helper.Saveuser_Email(email: data.data?.email)
                                                                   
                                                            Helper.Saveuser_id(user_id :" \(data.data?.id ?? 0) ")
                                                                  self.showStatus(image: #imageLiteral(resourceName: "true"), message: "Send Successfully")
                                                                  }
                                                           
                                                           
                                                                  
                                                              }
                
            
            
        }
    
          
    
}

