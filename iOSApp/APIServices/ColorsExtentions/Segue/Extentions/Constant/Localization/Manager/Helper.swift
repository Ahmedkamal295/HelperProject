//
//  Helper.swift
//  DemoProject
//
//  Created by MOHAB on 2/29/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

import UIKit

class Helper: NSObject {
    
    class func api_toket()->String {
        
        let api_token = "token"
        return api_token
    }
    
    class func Trip_id()->String {
           
           let Trip_id = "Trip_id"
           return Trip_id
       }
    
    class func user_name()->String {
           
           let user_name = "name"
           return user_name
       }
    class func user_id()->String {
        
        let user_id = "user_id"
        return user_id
    }
    class func user_notification()->String {
              
              let user_notification = "user_notification"
              return user_notification
          }
    
    class func user_Wallet()->String {
                
                let user_Wallet = "Wallet"
                return user_Wallet
            }
    
    class func user_image()->String {
             
             let user_image = "Profileimage"
             return user_image
         }

    class func user_email()->String {
        
        let user_email = "email"
        return user_email
    }
    class func user_Phone()->String {
           
           let user_Phone = "phone"
           return user_Phone
       }
    
    
    class func SaveApitoken(token : String?){
        
        let def = UserDefaults.standard
        def.setValue(token, forKey: api_toket())
        def.synchronize()
        
        
    }
    
    class func SaveTrip_id(Tripid : String?){
           
           let def = UserDefaults.standard
           def.setValue(Tripid, forKey: Trip_id())
           def.synchronize()
           
           
       }
    
    class func Saveuser_namen(name : String?){
        
        let def = UserDefaults.standard
        def.setValue(name, forKey: user_name())
        def.synchronize()
        
        
    }
    class func Saveuser_id(user_id : String?){
        
        let def = UserDefaults.standard
        def.setValue(user_id, forKey: self.user_id())
        def.synchronize()
        
        
    }
    class func Saveuser_notification(notification : String?){
        
        let def = UserDefaults.standard
        def.setValue(notification, forKey: user_notification())
        def.synchronize()
        
        
    }
    
    class func Saveuser_Wallet(Wallet : String?){
           
           let def = UserDefaults.standard
           def.setValue(Wallet, forKey: user_Wallet())
           def.synchronize()
           
           
       }
    
    class func Saveuser_Image(image : String?){
        
        let def = UserDefaults.standard
        def.setValue(image, forKey: user_image())
        def.synchronize()
        
        
    }
    
    class func Saveuser_Email(email : String?){
        
        let def = UserDefaults.standard
        def.setValue(email, forKey: user_email())
        def.synchronize()
        
        
    }
    class func Saveuser_phone(phone : String?){
          
          let def = UserDefaults.standard
          def.setValue(phone, forKey: user_Phone())
          def.synchronize()
          
          
      }
    
    
    class func getapitoken()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: api_toket()) as? String
        
        
        
    }
    
    class func getTrip_id()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: Trip_id()) as? String
        
        
        
    }
    
    class func getaUser_name()->String? {
          
          let def = UserDefaults.standard
          return def.object(forKey: user_name()) as? String
          
          
          
      }
    
    class func getaUser_id()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: user_id()) as? String
        
        
        
    }
    
    class func getNotification()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: user_notification()) as? String
        
        
        
    }
    class func getWallet()->String? {
           
           let def = UserDefaults.standard
           return def.object(forKey: user_Wallet()) as? String
           
           
           
       }

    
    class func getauser_name()->String? {
           
           let def = UserDefaults.standard
           return def.object(forKey: user_name()) as? String
           
           
           
       }

    class func getauser_Image()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: user_image()) as? String
        
        
        
    }

    class func getauser_Email()->String? {
              
              let def = UserDefaults.standard
              return def.object(forKey: user_email()) as? String
              
              
              
          }
    class func getauser_Phone()->String? {
                 
                 let def = UserDefaults.standard
                 return def.object(forKey: user_Phone()) as? String
                 
                 
                 
             }
    
    
    class func Fcm_toket()->String {
        
        let Fcm_token = "Fcmtoken"
        return Fcm_token
    }
    
    
    
    
    
    class func SaveFcmtoken(Fcmtoken : String?){
        
        let def = UserDefaults.standard
        def.setValue(Fcmtoken, forKey: Fcm_toket())
        def.synchronize()
        
        
    }
    
    
    class func getFcmtoken()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: Fcm_toket()) as? String
        
        
        
    }
    
    
    
    class func restartApp(_ id : String){
        guard let window = UIApplication.shared.keyWindow else{return}
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc : UIViewController
        
        
        vc = sb.instantiateViewController(withIdentifier: id)
        
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
    }
    
    func restartApplication() {
        
        
    }
    
}
