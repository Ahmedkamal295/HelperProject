//
//  SearchVC.swift
//  iOSApp
//
//  Created by Ahmed kamal on 9/6/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    var favouritsArray = [FavouriteData]()
   // var SearchArray = [SearchModel]()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var search: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

          collectionView.dataSource = self
          collectionView.delegate = self
           getData(keyword: "")
            search.delegate = self
    }
    
    @IBAction func btnback(_ sender: Any) {
           appscene.SideMenu()
       }

}
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouritsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyFavouritsCell
      
        return cell
        
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ///////////////
    }
}

extension SearchVC : UICollectionViewDelegateFlowLayout {
    
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


extension SearchVC :  UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        if searchText == "" {
           // SearchArray.removeAll()
            self.collectionView.reloadData()
            
            return
            
        }
       getData(keyword: searchText )
     
    }
}

extension SearchVC {


func getData(keyword : String){
     
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
                                         // self.SearchArray.removeAll()
                                        self.collectionView.reloadData()
                                    
                                                                        
                                                                             
                             }
                                                                       
                       }
                       
               }
    
    
}
    
}
