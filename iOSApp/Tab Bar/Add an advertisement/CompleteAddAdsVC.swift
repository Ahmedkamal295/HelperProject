//
//  CompleteAddAdsVC.swift
//  iOSApp
//
//  Created by Ahmed kamal on 9/8/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class CompleteAddAdsVC: UIViewController , UITextViewDelegate , UITextFieldDelegate {
    
    @IBOutlet weak var AddAddressesVC: UITextField!
    @IBOutlet weak var buyPriceTF: UITextField!
    @IBOutlet weak var SalePriceTF: UITextField!
    @IBOutlet weak var SizeTF: UITextField!
    @IBOutlet weak var ColorTF: UITextField!
    @IBOutlet weak var buyYearsTF: UITextField!
    @IBOutlet weak var buyPlaceTF: UITextField!
    @IBOutlet weak var disadvantageTF: UITextField!
    @IBOutlet weak var MessageTV: UITextView!
    @IBOutlet weak var AcceptBtn: UIButton!
    
      var isAccept = false
      var brand_id = ""
      var category_is = ""
    
      var imagesCap = [UIImage]()
    
      var pickerOfstartDate = UIDatePicker()
      var pickerOfEndDate = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          pickerOfstartDate.datePickerMode = .date
          pickerOfEndDate.datePickerMode = .date
          buyYearsTF.inputView = pickerOfstartDate
     
      
         
         buyYearsTF.delegate = self
         pickerOfstartDate.addTarget(self, action: #selector(CompleteAddAdsVC.dateChanged(datePicker:)), for: .valueChanged)
        
        MessageTV.textColor = UIColor.lightGray
        MessageTV.delegate = self
        MessageTV.text = "الوصف"
        MessageTV.textAlignment = .right
                          
      
        
    }
    
    @objc func dateChanged(datePicker : UIDatePicker) {
             
           if datePicker == pickerOfstartDate {
             let dateFormatter = DateFormatter()
               dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
         dateFormatter.dateFormat = "yyyy-MM-dd"
         buyYearsTF.text = dateFormatter.string(from: pickerOfstartDate.date)
               
            
               
           }
        
         
             
         }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
           
           if MessageTV.textColor == UIColor.lightGray {
               MessageTV.text = ""
               MessageTV.textColor = UIColor.black
           }
       }
    
    
    @IBAction func AcceptAction(_ sender: Any) {
   
        if isAccept {
            
             isAccept = false
            
            AcceptBtn.setImage(nil, for: .normal)
            
        }else {
            
            isAccept = true
             AcceptBtn.setImage(#imageLiteral(resourceName: "ic_check_mark_green"), for: .normal)
            
        }
        
    
    }
    

    @IBAction func PayAction(_ sender: Any) {
        
        if isNotEmptyString(text: AddAddressesVC.text!, withAlertMessage: "من فضلك ادخل عنوان الاعلان".localized) , isNotEmptyString(text: buyPriceTF.text!, withAlertMessage: "من فضلك ادخل سعر الشراء".localized) , isNotEmptyString(text: SalePriceTF.text!, withAlertMessage: "من فضلك ادخل سعر البيع") , isNotEmptyString(text: SizeTF.text!, withAlertMessage: "من فضلك ادخل الحجم") , isNotEmptyString(text: ColorTF.text!, withAlertMessage: "من فضلك ادخل اللون") , isNotEmptyString(text: buyYearsTF.text!, withAlertMessage: "من فضلك ادخل سنة الشراء"), isNotEmptyString(text: buyPlaceTF.text!, withAlertMessage: "من فضلك ادخل مكان الشراء") , isNotEmptyString(text: disadvantageTF.text!, withAlertMessage: "من فضلك ادخل العيوب") , isNotEmptyString(text: MessageTV.text!, withAlertMessage: "من فضلك ادخل الوصف") {
            
            
            guard isAccept else {
                
                self.showAlertWithTitle(title: "", message: "يجب الموافقة على الشروط", type: .error)
                return
            }
            
            guard let id = Helper.getaUser_id() else {
                
                 alertSkipLogin()
                return
            }
            
              AddAds()
            
        }
        
      

    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        
       dismiss(animated: false, completion: nil)
    }
    
}
extension CompleteAddAdsVC {
    
    
    func AddAds(){
        self.view.lock()
        
                                      let param = [
                                      
                                        "seller_id" : Helper.getaUser_id() ?? "",
                                        "brands_id" : brand_id ,
                                        "categories_id" : category_is,
                                        "name" :  AddAddressesVC.text! ,
                                        "size" :  SizeTF.text!,
                                        "color" : ColorTF.text!,
                                        "purchase_year" : buyYearsTF.text! ,
                                        "where_to_buy" :  buyPlaceTF.text!,
                                        "defects" : disadvantageTF.text!,
                                        "description" :  MessageTV.text!,
                                        "price" : buyPriceTF.text!,
                                        "selling_price" :SalePriceTF.text! ,
                                         
                                          
                                          
                                         
                                        ]

                                      ApiServices.instance.uploadImage(methodType: .post, parameters: param as [String : AnyObject], url: "\(hostName)addproduct", imagesArray: imagesCap, profileImage: nil, commercial_register_image: nil, office_license_image: nil, id_image: nil) { (data : AddProductModel?, String) in
                                          
                                          self.view.unlock()
                                         if String != nil {
                                                                                               
                                                                                               
                                                                                 
                                        self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                       
                                            
                                            }else {
                                           
                                           guard let data = data else {
                                               return
                                           }
                                            
                                            
                                            self.showStatus(image: #imageLiteral(resourceName: "true"), message: "Added Successfully")
                                            appscene.SideMenu()
                                
                                           print(data)
                                           
                                       }
                                }
        
    }
    
}
