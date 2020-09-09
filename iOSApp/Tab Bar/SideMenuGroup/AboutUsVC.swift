//
//  AboutUsVC.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class AboutUsVC: UIViewController {

      var AboutArr = [AboutData]()
    @IBOutlet weak var MessageTV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

         navigationController?.isNavigationBarHidden = true
          self.MessageTV.isEditable = false
        AboutUsVc()
    }
    @IBAction func btnback(_ sender: Any) {
        appscene.SideMenu()
    }
    

   

}
extension AboutUsVC {
   
         func AboutUsVc() {
                    self.view.lock()
                      

                      ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)pages?key=about") { (data : AboutModel?, String) in
                                                                     
                            self.view.unlock()
                          
                        //  self.AdsCollectionVoew.showLoader()
                        
                                    if String != nil {
                                                   
                                    self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                             
                                        }else {
                                                                      
                                            guard let data = data else {
                                                return
                                                    }
                                            print(data)
                                                                      
                                        self.MessageTV.text = data.data?.content ?? ""
                                       
                                        self.MessageTV.isEditable = false
                                                                        
                                                                     
                                                                          
                          }
                                                                    
                    }
                    
            }
        }

    

    

