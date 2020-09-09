//
//  SendEmailVC.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class SendEmailVC: UIViewController {

     var email = ""
    @IBOutlet weak var txtCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnback(_ sender: Any) {
         navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSend(_ sender: Any) {
        
        if isNotEmptyString(text: self.txtCode.text!, withAlertMessage: "Please insert your code".localized) {
                  
                  self.view.lock()
                  
                  VerifyCode()
        }

    }
    func VerifyCode() {
               view.lock()
               let param = [
                   "email" : email,
                   "codeActive" : "\(txtCode.text!)"
               ]
               print(param)
               ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)check_code_activemail") { (data : VerificationModel?, String) in
                self.view.unlock()
                if String != nil {
                    self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                           
                } else {
                    guard let data = data else {return}
                    print(data)
                    
                    self.showStatus(image: #imageLiteral(resourceName: "true"), message: "Send Successfully")
                    
                     let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc  = storyboard.instantiateViewController(withIdentifier: "LoginVC")
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }


