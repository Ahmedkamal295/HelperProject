//
//  HomeVC.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit
import FSPagerView

class HomeVC: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {

    var bannerArray = [BannersData]()
     var allProductArray = [AllProductData]()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pagerView: FSPagerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllProduct()
        getBanners()
           pagerView.dataSource = self
           pagerView.delegate = self
           pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
           pagerView.isInfinite = true
           pagerView.transformer = FSPagerViewTransformer(type: .invertedFerrisWheel)
           pagerView.automaticSlidingInterval = 3.0
           
           self.collectionView.reloadData()
        
           collectionView.dataSource = self
           collectionView.delegate = self
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return bannerArray.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        print("\(hostBanner)" + "\(bannerArray[index].image ?? "")")
                  
        cell.imageView?.loadImage(URL(string: "\(hostBanner)" + "\(bannerArray[index].image ?? "")"))
        
        return cell
    }
    @IBAction func openSideMenu(_ sender: Any) {
        if L102Language.currentAppleLanguage() == "ar"{
                       panel?.openRight(animated: true)
                          }else{

                              panel?.openLeft(animated: true)
                          }
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "SearchVC")
                navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allProductArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCell
        
         var model = allProductArray[indexPath.row]
        cell.lblName.text = model.name
        cell.lblColor.text = model.color
        cell.lblDescription.text = model.description
        cell.lblPrice.text = "\(model.price ?? Int(0.0))"
         cell.img.loadImage(URL(string: "\(Hostproducts)\(model.image ?? "")"))
        print("\(Hostproducts)\(model.image ?? "")")
        
    
        if allProductArray[indexPath.row].is_fav == 0   {
               cell.btnFav.setImage(#imageLiteral(resourceName: "fav_red"), for: .normal)

               }else {

                    cell.btnFav.setImage(#imageLiteral(resourceName: "fav_black"), for: .normal)

               }

        
        
        cell.AddFavourite = {
            
            self.AddFAvourite(products_id: "\(model.id ?? 0)", row: indexPath.row)
           
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        
                  vc.Product_id = "\(allProductArray[indexPath.row].id ?? 0)"
                  
                  print(allProductArray[indexPath.row].id ?? 0)
                  //self.present(vc, animated: false, completion: nil)
       
                 navigationController?.pushViewController(vc, animated: true)
                  
                  
              }
             
          }
       


extension HomeVC : UICollectionViewDelegateFlowLayout {
    
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
        return 10
    }
}


extension HomeVC {
    
    func getBanners(){
        
        
        self.view.lock()
          
          ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)banners") { (data : BannersModel?, String) in
                                                         
                                                    self.view.unlock()
              
                                                    // self.pagerView.showLoader()
            
                  
                                                        if String != nil {
                                       
                                                           self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                 
                                                        }else {
                                                          
                                                          guard let data = data else {
                                                              return
                                                          }
                                                          print(data)
                                                          
                                                            
                                                            self.bannerArray = data.data ?? []
                                                              
                                                              self.pagerView.reloadData()
                                                                                                       
                                                              
                                                          }
                                                   
                                                         
                                                          
                                }
        
           }
    
}

extension HomeVC {
    func getAllProduct() {
            self.view.lock()
              
              ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)all_products") { (data : AllProductModel?, String) in
                                                             
                                                             self.view.unlock()
                  
                                                             //self.collectionView.showLoader()
                
                      
                                                            if String != nil {
                                           
                                                               self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                     
                                                            }else {
                                                              
                                                              guard let data = data else {
                                                                  return
                                                              }
                                                              print(data)
                                                              
                                                          
                                                                self.allProductArray = data.data ?? []
                                                                self.collectionView.reloadData()
                                                                  
                                                                 
                                                                                                           
                                                                  
                                                              }
                                                       
                                                             
                                                              
                                                }
            
        
        
           }
    
    
     func AddFAvourite(products_id :String  ,row : Int) {
               
                   self.view.lock()
            
            
            let Param = [
            
                "users_id" : Helper.getaUser_id() ?? "" ,
                "products_id" : products_id
            
            ]
                     
            ApiServices.instance.getPosts(methodType: .post, parameters: Param as [String : AnyObject]  , url: "\(hostName)add_products_favorites") { (data : AddFAvouriteModel?, String) in
                                                                    
                                           self.view.unlock()
                         
                       //  self.AdsCollectionVoew.showLoader()
                       
                             
                                               if String != nil {
                                                  
                                                   self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                            
                                                           }else {
                                                                     
                                                           guard let data = data else {
                                                                   return
                                                                     }
                                                                     print(data)
                                                                      
                                                          self.collectionView.reloadData()
                                                                                                                  
                                                                         
                                                                     }
                                                              
                                                                    
                                                                     
                                                       }
                   
               
               
               }
    }


