//
//  ContactUsVC.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class ContactUsVC: UIViewController {

    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var MobileTF: UITextField!
    @IBOutlet weak var MessageTV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
    }
    @IBAction func btnBack(_ sender: Any) {
        appscene.SideMenu()
    }
    
    @IBAction func sendAction(_ sender: Any) {
        if isNotEmptyString(text: NameTF.text!, withAlertMessage: "Please insert your name") ,
            isNotEmptyString(text: MobileTF.text!, withAlertMessage: "Please insert Mobile"),
             isNotEmptyString(text: MessageTV.text!, withAlertMessage: "Please insert Message"){
                         
                     
        sendMessage()
        }
    }
    
}
extension ContactUsVC {
    
    
     func sendMessage(){
            
            view.lock()
                
                      let param = [
            
                      
                        "name" : "\(NameTF.text!)",
                        "mobile" : "\(MobileTF.text!)",
                        "msg_type_id" : "1" ,
                        "content" : "\(MessageTV.text!)",
                        
            ]
                       
        print(param)
        
            ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)add_msg") { (data : ContactModel?, String) in
                                                                 
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
                                                                  self.showStatus(image: #imageLiteral(resourceName: "true"), message: "Send Successfully")
                                                                  }
                                                           
                                                            
                                                                  
                                                              }
                
            
            
        }
    
          
    
}
