//
//  NotificationVC.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         navigationController?.isNavigationBarHidden = true
              tableView.reloadData()
              
              tableView.tableFooterView = UIView()
              tableView.separatorColor = UIColor.clear
              
              tableView.delegate = self
              tableView.dataSource = self
          
             
              if Helper.getaUser_id() == nil  {
                  
                tableView.isHidden = true
                
                showAlertWithTitle(title: "Error", message: "Please login First", type: .error )
            
                
              } else {
                 
                print("welcome")
              }
          }
    
      
    @IBAction func btnBack(_ sender: Any) {
        appscene.SideMenu()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NotificationCell
//        cell?.lblAddress.text = address[indexPath.row]
//        cell?.lblAddressLine1.text = addressLine1[indexPath.row]
//        cell?.lblAddressLine2.text = addressLine2[indexPath.row]
        return cell!
    }
}
