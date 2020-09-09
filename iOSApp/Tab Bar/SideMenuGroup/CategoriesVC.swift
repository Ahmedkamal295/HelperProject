//
//  CategoriesVC.swift
//  iOSApp
//
//  Created by Ahmed kamal on 9/2/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
   
     var Index = 0
     var CategoryCArray = [CategoriesData]()
     var StoresArray = [StoresData]()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        getCategoriesC()
       
         navigationController?.isNavigationBarHidden = true
         collectionView.dataSource = self
         collectionView.delegate = self
         tableView.dataSource = self
         tableView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryCArray.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellCollectionCategories
        
              cell.viewBG.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
              if indexPath.row == self.Index {
                   cell.viewBG.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                      }
               
               cell.lblName.text = CategoryCArray[indexPath.row].name
               cell.img.loadImage(URL(string: CategoryCArray[indexPath.row].img ?? ""))
               print(CategoryCArray[indexPath.row].img ?? "")
               
               return cell
           
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Index = indexPath.row
        collectionView.reloadData()
        
           
        getAllStores(id: "\(self.CategoryCArray[indexPath.row].id!)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize.init(width: 100 , height:120)
            
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StoresArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellTableCategories
        
                  cell.lblName.text = StoresArray[indexPath.row].seller_name
                  cell.lblStore.text = StoresArray[indexPath.row].name
                  cell.lblDescribtaion.text = StoresArray[indexPath.row].desc
                  cell.img.loadImage(URL(string: StoresArray[indexPath.row].img ?? ""))
               return cell
       }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 150
       }
       
    @IBAction func btnBack(_ sender: Any) {
        appscene.SideMenu()
    }
}


extension CategoriesVC {
     func getCategoriesC() {
        
              self.view.lock()
                     
       ApiServices.instance.getPosts(methodType: .post, parameters: nil  , url: "\(hostbosat)get_categores.php?lang=\(L102Language.currentAppleLanguage())") { (data : CategoriesModel?, String) in
        
             self.view.unlock()
                
             if String != nil {
                                             
             self.showAlertWithTitle(title: "Error".localized, message: String!, type: .error)
                                       
              }else {
                                                                
              guard let data = data else {
              return
              }
              print(data)
                                                                
              self.CategoryCArray = data.data ?? []
              self.collectionView.reloadData()
                                                                
               if self.CategoryCArray.count != 0 {
               self.getAllStores(id : "\(data.data![0].id!)")
                                                                  
             }
                                                                
            }
                                                          
                                                                
        }
              
          
          
  }
     func getAllStores(id : String){
        
            self.view.lock()
                   
     ApiServices.instance.getPosts(methodType: .post, parameters: nil  , url: "http://newskuwaitna.com/bothat/json_user/get_all_stores_categories.php?lang=ar&branch_id=\(id)") { (data : StoresModel?, String) in
      
                self.view.unlock()
              
                if String != nil {
                                           
                self.showAlertWithTitle(title: "Error".localized, message: String!, type: .error)
                                     
                    }else {
                                                              
                    guard let data = data else {
                     return
                    }
                                                              
                    print(data)
                    self.StoresArray = data.data ?? []
                    self.tableView.animateTable(tableView: self.tableView)
                                                                                                         
                                                                  
                    }
                                                        
                                                              
                }
            
        
        
        }
    }


