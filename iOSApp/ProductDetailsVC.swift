//
//  ProductDetailsVC.swift
//  iOSApp
//
//  Created by Ahmed kamal on 8/24/20.
//  Copyright © 2020 Ahmed kamal. All rights reserved.
//

import UIKit
import FSPagerView
class ProductDetailsVC: UIViewController , FSPagerViewDataSource , FSPagerViewDelegate {

        var SliderImages = [BannersData]()
    
        @IBOutlet weak var StartPrice: UILabel!
        @IBOutlet weak var EndPrice: UILabel!
        @IBOutlet weak var btnFavourite: UIButton!
        @IBOutlet weak var NameLabel: UILabel!
        @IBOutlet weak var dateLAbel: UILabel!
        @IBOutlet weak var AdsNumLabel: UILabel!
        @IBOutlet weak var SizeLabel: UILabel!
        @IBOutlet weak var ColorLabel: UILabel!
        @IBOutlet weak var YearLabel: UILabel!
        @IBOutlet weak var PlaceLabel: UILabel!
        @IBOutlet weak var StatusLabel: UILabel!
        @IBOutlet weak var PageController: UIPageControl!
        @IBOutlet weak var PagerView: FSPagerView!
        @IBOutlet weak var descriptionTV: UITextView!
        @IBOutlet weak var nameUser: UILabel!
        @IBOutlet weak var btnContact: UIButton!
        @IBOutlet weak var CollectionView: UICollectionView!
        /// layout views in screen
        @IBOutlet weak var ScrollHeight: NSLayoutConstraint!
        @IBOutlet weak var BGView: UIView!
        @IBOutlet weak var StartView: UIImageView!
        @IBOutlet weak var EndPriceView: UIView!
        @IBOutlet weak var StaryPriceLabel: UILabel!
        @IBOutlet weak var StartPriceCurrency: UILabel!
        @IBOutlet weak var EndPriceLabel: UILabel!
        @IBOutlet weak var EndPriceCurrency: UILabel!
        @IBOutlet weak var ProductDetailsView: UIView!
        @IBOutlet weak var ProductDescriptionView: UIView!
        @IBOutlet weak var ProfileView: UIView!
        
        
        var Product_id = ""
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
          
            PagerView.dataSource = self
            PagerView.delegate = self
               
            PagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.BGView.addSubview(PagerView)
            
            PagerView.addSubview(btnFavourite)
            PagerView.addSubview(PageController)
            PagerView.addSubview(StartView)
            PagerView.addSubview(EndPriceView)
            
            StartView.addSubview(StartPrice)
            StartView.addSubview(StaryPriceLabel)
            StartView.addSubview(StartPriceCurrency)
            
            setShadow(view: ProductDetailsView, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
            setShadow(view: ProductDescriptionView, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
            setShadow(view: ProfileView, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
                   
             PagerView.isInfinite = true
             PagerView.itemSize = CGSize(width: PagerView.frame.size.width, height: PagerView.frame.size.height)
            PagerView.transformer = FSPagerViewTransformer(type: .linear)
             PagerView.automaticSlidingInterval = 3.0
           
            CollectionView.dataSource = self
            CollectionView.delegate = self
            
             self.CollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
             GetDetails()
            GetBannerImages()
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            CollectionView.layer.removeAllAnimations()
//            ScrollHeight.constant = CollectionView.contentSize.height + 1150
            UIView.animate(withDuration: 0.5) {
                self.updateViewConstraints()
                self.loadViewIfNeeded()
            }
        }
        

       func numberOfItems(in pagerView: FSPagerView) -> Int {
                   return SliderImages.count
               }
               
               func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
                let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
                PageController.currentPage = PagerView.currentIndex
                cell.imageView?.loadImage(URL(string: "\(Hostproducts)\(SliderImages[index].image ?? "")"))
                PageController.currentPage = index
                print("\(hostBanner)\(SliderImages[index].image ?? "")")
                return cell
               }
        
        
        @IBAction func backAction(_ sender: Any) {

            appscene.SideMenu()

        }
    @IBAction func FavouriteAction(_ sender: Any) {
        AddFAvourite(products_id: Product_id)
    }
    
    }
    extension ProductDetailsVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 6
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductDetailsCell
            
            setShadow(view: cell, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
            
            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.size.width - 30)/2
                return CGSize.init(width: width , height: 200)
                        
                        
                    }
        
    }
    extension ProductDetailsVC {
        
        func GetDetails(){
            
           self.view.lock()
           
            let param = [
            
                "Product_id" : self.Product_id
            
            ]
            
            print(param)
            
                
            ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)viewproduct") { (data : DetailsModel?, String) in
                                                          
                                                          self.view.unlock()
             
                                                         if String != nil {
                                        
                                                            self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                  
                                                         }else {
                                                           
                                                           guard let data = data else {
                                                               return
                                                           }
                                                           print(data)
                                                           
                                                            self.StartPrice.text = "\(data.data?.price ?? 0)"
                                                            self.EndPrice.text = "\(data.data?.selling_price ?? 0)"
                                                            self.NameLabel.text = data.data?.name
                                                            self.descriptionTV.text = data.data?.description
                                                            self.nameUser.text = data.data?.username
                                                            self.SizeLabel.text = data.data?.size
                                                            self.ColorLabel.text = data.data?.color
                                                            self.YearLabel.text = data.data?.purchase_year
                                                            self.PlaceLabel.text = data.data?.where_to_buy
                                                            self.StatusLabel.text = data.data?.defects
                                                            self.dateLAbel.text = data.data?.created_at
                                                            self.AdsNumLabel.text = "\(data.data?.id ?? 0)"
                                                             
                                                       }
                                                }
                    }
           
         func GetBannerImages(){
                     self.view.lock()
               
             let param = [
                    
                        "Product_id" : self.Product_id
                    
                    ]
                    
                    print(param)
                   
                    
            ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)images_product") { (data : BannersModel?, String) in
                                                              
                                                              self.view.unlock()
                 
                                                             if String != nil {
                                            
                                                                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                      
                                                             }else {
                                                               
                                                               guard let data = data else {
                                                                   return
                                                               }
                                                               print(data)
                                                               
                                                         self.SliderImages = data.data ?? []
                                                         self.PageController.numberOfPages = self.SliderImages.count
                                                         self.PagerView.reloadData()
                                                                
                                                                 
                                                              
                                                               
                                                           }
                                            }
                            
                        }
               
               
        
        
        
    }
extension ProductDetailsVC {
func AddFAvourite(products_id :String) {
                
                    self.view.lock()
             
             let Param = [
             
                 "users_id" : Helper.getaUser_id() ?? "" ,
                 "products_id" : products_id
             
                ] as [String : Any]
                      
             ApiServices.instance.getPosts(methodType: .post, parameters: Param as [String : AnyObject]  , url: "\(hostName)add_products_favorites") { (data : AddFAvouriteModel?, String) in
                                                                     
                            self.view.unlock()
                        
                            if String != nil {
                                                   
                                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                             
                                        }else {
                                                                      
                                            guard let data = data else {
                                             return
                                             }
                                             print(data)
                                                                       
                                                         
                                                }
                                                                  
                                            }
                    
                
                
                }
     }









