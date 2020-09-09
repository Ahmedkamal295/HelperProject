//
//  SendCodeVC.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class SendCodeVC: UIViewController {

     var email = ""
    @IBOutlet weak var codeTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnback(_ sender: Any) {
         navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnVerify(_ sender: Any) {
        
         if isNotEmptyString(text: self.codeTF.text!, withAlertMessage: "Please insert your code".localized) {
                  
                  self.view.lock()
                  
                  SendCode()
              }
          }
     func SendCode() {
               view.lock()
               let param = [
                   "email" : email,
                   "codeEmail" : "\(codeTF.text!)"
               ]
               print(param)
               ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)check_code_changepassword") { (data : SendCodeModel?, String) in
                self.view.unlock()
                if String != nil {
                    self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                           
                } else {
                    guard let data = data else {return}
                    print(data)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                    vc.email = self.email
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }


