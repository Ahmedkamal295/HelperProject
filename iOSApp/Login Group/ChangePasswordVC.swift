//
//  ChangePasswordVC.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    var email = ""
    
    @IBOutlet weak var nwePasswordTF: UITextField!
    @IBOutlet weak var confirmNewPasswordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnback(_ sender: Any) {
         navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnChange(_ sender: Any) {
         if isNotEmptyString(text: self.nwePasswordTF.text!, withAlertMessage: "Please insert your new password".localized) {
                     
                     self.view.lock()
                     
                     ChangePassword()
                 }
             }
     func ChangePassword() {
               view.lock()
               let param = [
                   "email" : email,
                   "password" : "\(nwePasswordTF.text!)"
               ]
               print(param)
               ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)change_password") { (data : ChangePasswordModel?, String) in
                self.view.unlock()
                if String != nil {
                    self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                           
                } else {
                    guard let data = data else {return}
                    print(data)
                    Helper.restartApp("LoginVC")
                }
            }
        }
    }


