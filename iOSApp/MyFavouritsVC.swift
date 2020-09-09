//
//  MyFavouritsVC.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class MyFavouritsVC: UIViewController {
 
     var favouritsArray = [FavouriteData]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         navigationController?.isNavigationBarHidden = true
        getAllProduct()
           self.collectionView.reloadData()
        
           collectionView.dataSource = self
           collectionView.delegate = self
    }

    @IBAction func btnback(_ sender: Any) {
        appscene.SideMenu()
    }
    
    
}

extension MyFavouritsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouritsArray.count
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
               
                         vc.Product_id = "\(favouritsArray[indexPath.row].id ?? 0)"
                         print(favouritsArray[indexPath.row].id ?? 0)
                         self.present(vc, animated: false, completion: nil)
                         //navigationController?.pushViewController(vc, animated: true)
                         
                         
                     }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyFavouritsCell
        
        var model = favouritsArray[indexPath.row]
          
             cell.lblDescription.text = model.description
             cell.lblName.text = model.name
             cell.lblPrice.text = "\(model.price ?? Int(0.0))"
             cell.imgProduct.loadImage(URL(string: "\(Hostproducts)\(model.image ?? "")"))
               print("\(Hostproducts)\(model.image ?? "")")
          
       
        
        cell.DeleteFavourite = {
            
            self.DeleteFAvourite(products_id: "\(model.id ?? 0)", row: indexPath.row)
            
            
        }
              
        return cell
        
      
    }
    
  
}

extension MyFavouritsVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (collectionView.frame.width - 10)/2, height: 190)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}



extension MyFavouritsVC {
     func getAllProduct() {
        
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
                                                             
                                                                self.collectionView.reloadData()
                                                                                                           
                                                                    
                                                                }
                                                          
                                                                
                                                  }
              
          
          
             }
       func DeleteFAvourite(products_id :String  ,row : Int) {
                 
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
                                                  
                                                  self.collectionView.reloadData()
                                                                                                                    
                                                                           
                                                                       }
                                                                
                                                                      
                                                                       
                                                         }
                     
                 
                 
                 }
      }


