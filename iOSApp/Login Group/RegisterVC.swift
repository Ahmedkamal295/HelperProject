//
//  RegisterVC.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var PasswordConfirmationTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnback(_ sender: Any) {
         navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerAction(_ sender: Any) {
        
        if isNotEmptyString(text: nameTF.text!, withAlertMessage: "Please insert your name") ,
            isNotEmptyString(text: EmailTF.text!, withAlertMessage: "Please insert Email"),
             isNotEmptyString(text: passwordTF.text!, withAlertMessage: "Please insert password"),
             isNotEmptyString(text: PasswordConfirmationTF.text!, withAlertMessage: "Please insert ConfirmationPassword"){

             Register()
        }
       
        
    }
    

}

extension RegisterVC {
    
     func Register(){
            
            view.lock()
                
                      let param = [
            
                        "name" : "\(nameTF.text!)",
                        "email" : "\(EmailTF.text!)",
                        "password" : "\(passwordTF.text!)",
                        "password_confirmation" : "\(PasswordConfirmationTF.text!)",
            ]
                       
                    print(param)
        
            ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)register") { (data : RegisterModel?, String) in
                                                                 
                     self.view.unlock()
                      
                    //  self.AdsCollectionVoew.showLoader()
                    
                          if String != nil {
                                               
                             self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                         
                               }else {
                                                                  
                                guard let data = data else {
                                     return
                                     }
                                  print(data)
                            
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: "SendEmailVC") as! SendEmailVC
                                            vc.email = self.EmailTF.text!
                                            self.navigationController?.pushViewController(vc, animated: true)
                                          
                                        }
                                                           
                                                           
                                 }
                
            
            
        }
    
          
    
}

