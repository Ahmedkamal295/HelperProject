//
//  AddAdsVC.swift
//  iOSApp
//
//  Created by Ahmed kamal on 9/8/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
class AddAdsVC: UIViewController{

    var imagesCap = [UIImage]()
    var ImagesTest = [UIImage]()
    var images = [PHAsset]()
    
    var BrandsPicker = UIPickerView()
    var CategoriesPicker = UIPickerView()
    var BrandsId :Int?
    var CategoriesId :Int?
       
   var BrandsArray = [BrandsData]()
   var categoryBybrandIDArry = [categoryBybrandIDData]()
    
    @IBOutlet weak var CollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var BrandTF: UITextField!
    @IBOutlet weak var categoryTF: UITextField!
    override func viewDidLoad() {
    super.viewDidLoad()

        CollectionHeight.constant = 0
        BrandTF.setPadding(left: 16, right: 16)
        categoryTF.setPadding(left: 16, right: 16)
        
        self.BrandTF.inputView = BrandsPicker
        self.categoryTF.inputView = CategoriesPicker
        
       
        getAllBrands()
    }
    
    func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
                    var arrayOfImages = [UIImage]()
                    for asset in assets {
                        let manager = PHImageManager.default()
                        let option = PHImageRequestOptions()
                        var image = UIImage()
                        option.isSynchronous = true
                        manager.requestImage(for: asset, targetSize:PHImageManagerMaximumSize, contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                            image = result!
                            arrayOfImages.append(image)
                        })
                    }

                    return arrayOfImages
                }
       
  
    @IBAction func AddPhotosActions(_ sender: Any) {
    
       guard !(imagesCap.count >= 5) else {

           self.showAlertWithTitle(title: "", message: "you can not choose greater than 5 images", type: .warning)

           return
       }

                        let imagePicker = ImagePickerController()

                          imagePicker.settings.theme.selectionStyle = .numbered

                          imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
                          imagePicker.settings.selection.unselectOnReachingMax = false

                          imagePicker.settings.selection.max = 5

                               let start = Date()
                               self.presentImagePicker(imagePicker, select: { (asset) in
                                   print("Selected: \(asset)")
                                   var x = 0
                                   for item in self.images {

                                    if item == asset {
                                    self.images.remove(at: x)

                                        }
                                     x = x + 1
                                    }

                                   self.images.append(asset)
                               }, deselect: { (asset) in
                                   print("Deselected: \(asset)")

                                   var x = 0
                                   for item in self.images {


                                       if item == asset {

                                           self.images.remove(at: x)

                                       }

                                       x = x + 1

                                   }

                               }, cancel: { (assets) in
                                   print("Canceled with selections: \(assets)")
                               }, finish: { (assets) in
                                   print("Finished with selections: \(assets)")

                              self.imagesCap = self.getAssetThumbnail(assets: self.images)
                              self.CollectionHeight.constant = 120
                              self.collectionView.reloadData()

                               }, completion: {
                                   let finish = Date()
                                   print(finish.timeIntervalSince(start))

                               })

   }
  
          
    @IBAction func NextAction(_ sender: Any) {
    
    guard imagesCap.count != 0 else {
              
              self.showAlertWithTitle(title: "", message: "من فضلك اختر صور للاعلان", type: .error)
              
              return
          }
          
          guard let brand_id = self.BrandsId else {
              
              self.showAlertWithTitle(title: "", message: "من فضلك اختر الماركة", type: .error)
              
              return
          }
          
          guard let category_id = self.CategoriesId  else {
              
              self.showAlertWithTitle(title: "", message: "من فضلك اختر القسم", type: .error)
              
              return
          }
          
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let vc  = storyboard.instantiateViewController(withIdentifier: "CompleteAddAdsVC") as! CompleteAddAdsVC
          vc.modalPresentationStyle = .fullScreen

          vc.brand_id = "\(brand_id)"
          vc.imagesCap = self.imagesCap
          vc.category_is = "\(category_id)"
          present(vc, animated: true, completion: nil)
          
      }
      
}

extension AddAdsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imagesCap.count != 0 {
                          
            DispatchQueue.main.async {
            self.CollectionHeight.constant = 120
            }
            
            collectionView.updateConstraints()
            self.collectionView.reloadData()
        
                return imagesCap.count
                      }else {
             DispatchQueue.main.async {
            self.CollectionHeight.constant = 0
                                     }
         
                    return 0
                }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AddCell
        
        if imagesCap.count != 0 {
            
              self.CollectionHeight.constant = 120
                    var image = imagesCap[indexPath.row]
                    cell.img.image = image
            
                cell.DeleteFromGallery = {
                
                self.imagesCap.remove(at: indexPath.row)
              
                self.images.remove(at: indexPath.row)

                self.collectionView.reloadData()
                
            }
            
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                    
                    let width = (collectionView.frame.size.height - 15)
                    return CGSize.init(width: width , height: width)
                }
}


extension AddAdsVC :UIPickerViewDelegate, UIPickerViewDataSource {
    
    func initPickers(picker: UIPickerView) {
              picker.dataSource = self as! UIPickerViewDataSource
              picker.delegate = self as! UIPickerViewDelegate
                  picker.tintColor = #colorLiteral(red: 0.840886116, green: 0.6630725861, blue: 0.2519706488, alpha: 1)
                  picker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
              }
              
              func numberOfComponents(in pickerView: UIPickerView) -> Int {
                  return 1
              }
              
              func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                
                if pickerView == BrandsPicker {
                    
                     return BrandsArray.count
                }else {
                    
                    
                     return categoryBybrandIDArry.count
                }
                  
              
              }
              
              func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                  
                  
                 if pickerView == BrandsPicker{

                    BrandsId = BrandsArray[row].id

                    return BrandsArray[row].name

                 }else {
                    
                    CategoriesId = categoryBybrandIDArry[row].id

                    return categoryBybrandIDArry[row].name
                    
                }
                  return ""
      }
              
              func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                  
             if pickerView == BrandsPicker{
              BrandTF.text = BrandsArray[row].name
              BrandsId = BrandsArray[row].id
                
                categoryBybrandID(category_id: "\(BrandsId ?? 0)", Index: 0)
             }else {
                
                categoryTF.text = categoryBybrandIDArry[row].name
                CategoriesId = categoryBybrandIDArry[row].id
                
                }
            }


    
}


extension AddAdsVC {
    
      func getAllBrands(){
              self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)allbrands") { (data : BrandsModel?, String) in
                                                       
                                                       self.view.unlock()
          
                
                                                      if String != nil {
                                     
                                                         self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                               
                                                      }else {
                                                        
                                                        guard let data = data else {
                                                            return
                                                        }
                                                        print(data)
                                                        
                                                        self.BrandsArray = data.data ?? []
                                                      self.initPickers(picker: self.BrandsPicker)
                                                       
                                                        
                                                    }
                                            }
                     
                 }
        
        func categoryBybrandID(category_id : String , Index : Int){
              self.view.lock()
        
      
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)categoryBybrandID/\(category_id)") { (data : categoryBybrandIDModel?, String) in
                                                       
                                                       self.view.unlock()
          
               
                                                      if String != nil {
                                     
                                                         self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                               
                                                      }else {
                                                        
                                                        guard let data = data else {
                                                            return
                                                        }
                                                        print(data)
                                                        
                                                        self.categoryBybrandIDArry = data.data ?? []
                                                         self.initPickers(picker: self.CategoriesPicker)
                                                       
                                                        
                                                    }
                                        }
                     
                 }
        
        
        
    }
