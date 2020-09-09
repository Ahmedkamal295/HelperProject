//
//  APIServices.swift
//  DemoProject
//
//  Created by Mohab on 8/1/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//


import Foundation
import UIKit
import Alamofire

class ApiServices : UIViewController {
      var lang : String = "ar"
    static let instance = ApiServices()
    
    func getPosts<T : Decodable>(methodType: HTTPMethod = .post , parameters: [String: AnyObject]? = nil , url : String , Completion : @escaping (T? ,String?)->Void){
        
        if L102Language.currentAppleLanguage() == arabicLang {
            self.lang = "ar"
        }else{
            self.lang = "ar"
        }
        
        var urlString: String = ""
        var headers: HTTPHeaders? = nil
        
        if Helper.getapitoken() != "" && Helper.getapitoken() != nil {
            headers = [
                "Accept-Language": self.lang,
                "Authorization": "Bearer \(Helper.getapitoken()!)"
            ]
        }else{
            headers = [
                "Accept-Language": self.lang
            ]
        }
        let net = NetworkReachabilityManager()
        net?.startListening()
        
        net?.listener =
            { status in
                
                if  net?.isReachable ?? false
                {
                    
                    Alamofire.request(url, method: methodType, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
                        print(urlString , methodType , parameters)
                        
                        debugPrint(response)
                        
                        if response.result.isSuccess {
                            
                            let dict = response.result.value! as! [String: Any]
                            print(dict)
                            
                                if dict["status"] as? Bool == true || dict["status"] as? String == "true" ||  dict["value"] as? String == "true" ||  dict["value"] as? Bool == true {


                                print(response.data)
        
                                guard let data = response.data else {
                                    return
                                }
        do {
        
            let Posts = try JSONDecoder().decode(T.self, from: data)
        
             Completion(Posts, nil)
        }catch let error {
        
            Completion(nil , error.localizedDescription)
            print("////////===========" , error)
        
        }
        
                                
                            }else{
                                if let dictError = dict["error"] as? String {
                                    Completion(nil , dictError)
                                }else {
                                    guard let errorStr = dict["msg"] as? String else {
                                        let errorsDict = dict["msg"] as! [String: Any]
                                        let errorsArr = errorsDict.values.first as! [String]
                                        
                                         Completion(nil , errorsArr[0])
                                        return
                                    }
                                     Completion(nil , errorStr)
                                }
                            }
                            
                        } else { //FAILURE
                      
                            
                              Completion(nil , response.result.error?.localizedDescription)
                        }}
                }
                else
                {
            
                    Completion(nil,nil)
                    
                  
                    self.showStatus(image:#imageLiteral(resourceName: "noEntarnet"), message: "No internet")
                    
                }
        }
        

        
    }
    func uploadImage<T : Decodable>(methodType: HTTPMethod = .post , parameters: [String: AnyObject]? = nil , url : String , imagesArray: [UIImage]? = nil, profileImage: UIImage? = nil,commercial_register_image: UIImage? = nil,office_license_image:UIImage? = nil,id_image:UIImage? = nil , Completion : @escaping (T? ,String?)->Void) {
          
          var headers: HTTPHeaders? = nil
          
          if Helper.getapitoken() != "" && Helper.getapitoken() != nil{
              headers = [
                  "Accept-Language": "ar",
                  "Authorization": "bearer \(Helper.getapitoken()!)"
              ]
          }else{
              headers = [
                  "Accept-Language": "ar"
              ]
          }
          
       
          
          
          
          let URL = try! URLRequest(url: url, method: .post, headers: headers)
          
          Alamofire.upload(
              multipartFormData: { multipartFormData in
                  
                  if(profileImage != nil ){
                      if  let profileImageData = profileImage?.jpegData(compressionQuality: 0.3) {
                          multipartFormData.append(profileImageData , withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
                      }
                  }
                  
                  if imagesArray != nil{
                      for (image) in imagesArray! {
                          
                          if  let imageData = image.jpegData(compressionQuality: 0.3) {
                              multipartFormData.append(imageData , withName: "image[]", fileName: "image\(image).jpg", mimeType: "image/jpg")
                          }
                      }
                  }
                  if(commercial_register_image != nil ){
                      if  let profileImageData = commercial_register_image?.jpegData(compressionQuality: 0.3) {
                          multipartFormData.append(profileImageData , withName: "commercial_register_image", fileName: "image.jpg", mimeType: "image/jpg")
                      }
                  }
                  if(office_license_image != nil ){
                      if  let profileImageData = office_license_image?.jpegData(compressionQuality: 0.3) {
                          multipartFormData.append(profileImageData , withName: "office_license_image", fileName: "image.jpg", mimeType: "image/jpg")
                      }
                  }
                  if(id_image != nil ){
                      if  let profileImageData = id_image?.jpegData(compressionQuality: 0.3) {
                          multipartFormData.append(profileImageData , withName: "id_image", fileName: "image.jpg", mimeType: "image/jpg")
                      }
                  }
                  
                  for (key, value) in parameters! {
                      multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                  }
                  
          },
              with: URL,
              encodingCompletion: { encodingResult in
                  switch encodingResult {
                  case .success(let request, _, _):
                      print("success")
                      request.uploadProgress(closure: { (progress_) in
                          print("Upload Progress: \(progress_.fractionCompleted)")
                          print("Upload totalUnitCount: \(progress_.totalUnitCount)")
                      })
                      request.validate(statusCode: 200..<500)
                      request.responseJSON { response in
                          
                          debugPrint("uploadRegistration: \(response)")
                          if response.result.isSuccess {
                              request.uploadProgress(closure: { (progress_) in
                                  print("Upload Progress: \(progress_.fractionCompleted)")
                                  print("Upload totalUnitCount: \(progress_.totalUnitCount)")
                              })
                              let dict = response.result.value! as! Dictionary<String, Any>
                              
                              print(response.result)
                              print(response)
                              
                              if (dict["value"] as! Bool == false){
                                  let errorMsg = dict["msg"] as! String
                                  Completion(nil , errorMsg)
                                  
                              }else{
                                  let statusCode = response.response?.statusCode
                                  if statusCode! >= 200 && statusCode! <= 300 {
                                      print(response)
                                        guard let data = response.data else {
                                                                           return
                                                                       }
                                               do {
                                               
                                                   let Posts = try JSONDecoder().decode(T.self, from: data)
                                               
                                                    Completion(Posts, nil)
                                               }catch let error {
                                               
                                                Completion(nil , error.localizedDescription)
                                               print(error)
                                               
                                               }
                                               
                                  }else{
                                    Completion(nil , "Something Went Wrong.")
                                  }
                                  
                              }
                          }else { //FAILURE
                              print("error \(String(describing: response.result.error)) in serviceName: Upload Image")
                                Completion(nil, response.result.error?.localizedDescription)
                          }
                          
                      }
                  case .failure(let errorType):
                      print("encodingError:\(errorType)")
                      Completion(nil , errorType.localizedDescription)
                  }
          })
          
      }
    
}
