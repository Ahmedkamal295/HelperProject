//
//  CartVC.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class CartVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    var total = 0
    
    var favouritsArray = [FavouriteData]()
    
    @IBOutlet weak var btnCheckOut: UIButton!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var subTotalCart: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
        
        if Helper.getaUser_id() == nil  {
                    
            lblTo.isHidden = true
            btnCheckOut.isHidden = true
            subTotalCart.isHidden = true
            tableView.isHidden = true
                      
            showAlertWithTitle(title: "Error", message: "Please login First", type: .error )
                  
                      
             } else {
                       
                print("welcome")
            }
        getcart()
        navigationController?.isNavigationBarHidden = true
       
           tableView.tableFooterView = UIView()
           
           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               return 45
               
           }
           
       }
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritsArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellCart
        
         var model = favouritsArray[indexPath.row]
                
               cell?.lblName.text = model.name
               cell?.lblColor.text = model.color
               cell?.lblSize.text = model.size
               cell?.lblPrice.text = "\(model.price ?? Int(0.0))"
               cell?.img.loadImage(URL(string: "\(Hostproducts)\(model.image ?? "")"))
                             print("\(Hostproducts)\(model.image ?? "")")
                        
        cell?.DeleteCart = {
            self.Delete(products_id: "\(model.id ?? 0)", row: indexPath.row)
            
        }
        
        cell?.PlusCart = {
            
            cell?.lblNumber.text = String((Int(cell?.lblNumber.text ?? "0") ?? 0) + 1)
            print(Int(cell?.lblPrice.text ?? "0"))
            print((model.price ?? 0))
            cell?.lblPrice.text = String((Int(cell?.lblNumber.text ?? "0") ?? 0) * (model.price ?? 0))
             
            
        }
        
        cell?.MinusCart = {
            if  (Int(cell?.lblNumber.text ?? "0") ?? 0) != 1 {
                cell?.lblNumber.text = String((Int(cell?.lblNumber.text ?? "0") ?? 0) - 1)
                cell?.lblPrice.text = String((Int(cell?.lblNumber.text ?? "0") ?? 0) * ((Int( "\(model.price ?? Int(0.0))") ?? 0)))
            }
            
        }
           return cell!
        
        
       }
    
    
    
     @IBAction func btnBack(_ sender: Any) {
        appscene.SideMenu()
            
        }
    @IBAction func btnCheckOut(_ sender: Any) {
    }
    
    }
   
    

    extension CartVC {
         func getcart() {
            
            let Param = [
            
                "users_id" : Helper.getaUser_id() ?? "" ,
               
            
            ]
                  self.view.lock()
                         
            ApiServices.instance.getPosts(methodType: .post, parameters: Param as [String : AnyObject]  , url: "\(hostName)view_products_favorites") { (data : FavouriteModel?, String) in
            
                                                                   
                                                                   self.view.unlock()
                        
                      //  self.AdsCollectionVoew.showLoader()
                      
                                                                  if String != nil {
                                                 
                                                                     self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                           
                                                                  }else {
                                                                    
                                                                    guard let data = data else {
                                                                        return
                                                                         
                                                                      
                                                                    }
                                                                    print(data)
                                                                    
                                                                    self.favouritsArray = data.data ?? []
                                                                    
                                                                    for item in self.favouritsArray {
                                                                    self.total = self.total + (item.price ?? 0)
                                                                    }
                                                                    
                                                                    self.subTotalCart.text = "\(self.total)"
                                                                    
                                                                    self.tableView.reloadData()
                                                                                                               
                                                                        
                                                                    }
                                                              
                                                                    
                                                      }
                  
              
              
                 }
        
        func Delete(products_id :String  ,row : Int) {
                       
                           self.view.lock()
                    
                    
                    let Param = [
                    
                        "users_id" : Helper.getaUser_id() ?? "" ,
                        "products_id" : products_id
                    
                    ]
                             
                    ApiServices.instance.getPosts(methodType: .post, parameters: Param as [String : AnyObject]  , url: "\(hostName)delete_products_favorites") { (data : DeleteFavoritesModel?, String) in
                                                                            
                                                   self.view.unlock()
                                 
                               //  self.AdsCollectionVoew.showLoader()
                               
                                     
                                                       if String != nil {
                                                          
                                                           self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                                    
                                                                   }else {
                                                                             
                                                                   guard let data = data else {
                                                                           return
                                                                             }
                                                                             print(data)
                                                                             
                                                                         
                                                                               
                                                                             
                                                              self.favouritsArray.remove(at: row)
                                                       
                                                                  
                                                                  self.total = 0
                                                                   for item in self.favouritsArray {
                                                                   self.total = self.total + (item.price ?? 0)
                                                                  }
                                                                  
                                                            self.subTotalCart.text = "\(self.total)"
                                                            self.tableView.reloadData()
                                                                                                                          
                                                                                 
                                                                             }
                                                                      
                                                                            
                                                                             
                                                               }
                           
                       
                       
                       }
            }




    
    

 
