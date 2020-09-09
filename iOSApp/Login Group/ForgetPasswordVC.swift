//
//  ForgetPasswordVC.swift
//  iOSApp
//
//  Created by Ahmed kamal on 8/26/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var EmailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func bynBack(_ sender: Any) {
         navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
       if isNotEmptyString(text: self.EmailTF.text!, withAlertMessage: "Please insert your email".localized) {
                   
                   self.view.lock()
                   
                   ForgetPassword()
               }
    }
    func ForgetPassword() {
               view.lock()
               let param = [
                   "email" : "\(EmailTF.text!)"
               ]
               print(param)
               ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)forgot_password") { (data : ForgetPasswordModel?, String) in
                self.view.unlock()
                if String != nil {
                    self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                           
                } else {
                    guard let data = data else {return}
                    
                    print(data)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "SendCodeVC") as! SendCodeVC
                    vc.email = self.EmailTF.text!
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }


