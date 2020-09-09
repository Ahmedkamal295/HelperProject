//
//  SideMenueVc.swift
//  iOSApp
//
//  Created by Ahmed kamal on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class SideMenueVc: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var tableView: UITableView!
      
    var MenuLabel = [("AboutUs".localized),("ContactUs".localized),("MyFavourite".localized),("Notification".localized),("Cart".localized),("Categories".localized),("ShareApp"),]
      
      var MenuImage = [UIImage(named:"b"), UIImage(named:"b"), UIImage(named:"b"),UIImage(named:"b"),UIImage(named:"b"),UIImage(named:"b"),UIImage(named:"b")]
      
    override func viewDidLoad() {
        super.viewDidLoad()

              tableView.reloadData()
              tableView.tableFooterView = UIView()
              tableView.separatorColor = UIColor.clear
              tableView.delegate = self
              tableView.dataSource = self
        
         imgProfile.layer.cornerRadius = imgProfile.frame.size.width / 2
         userName.text = Helper.getaUser_name()
         userEmail.text = Helper.getauser_Email()
        // imgProfile.image = Helper.getauser_Image()
        
           if Helper.getaUser_id() == nil  {
            
            userName.text = "Welcome iOS App".localized
            btnLogOut.setTitle("Log In".localized, for: .normal)
            btnLogOut.setTitleColor(UIColor.white, for: .normal)
            btnLogOut.backgroundColor = UIColor.red
            
        } else {
           
          print("welcome")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuLabel.count
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 60
       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MenuCell
           cell?.lblName.text = MenuLabel[indexPath.row]
           cell?.img.image = MenuImage[indexPath.row]
           return cell!
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if indexPath.row == 0 {
               
                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                   let centerVC: UIViewController = storyBoard.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
                   centerVC.modalPresentationStyle = .fullScreen
                   let centerNavVC = UINavigationController(rootViewController: centerVC)
                   panel!.center(centerNavVC)
               
           } else if indexPath.row == 1 {
               
               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                   let centerVC: UIViewController = storyBoard.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
                   centerVC.modalPresentationStyle = .fullScreen
                             let centerNavVC = UINavigationController(rootViewController: centerVC)
                             panel!.center(centerNavVC)
               
               
           } else if indexPath.row == 2 {
               
               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                   let centerVC: UIViewController = storyBoard.instantiateViewController(withIdentifier: "MyFavouritsVC") as! MyFavouritsVC
                   centerVC.modalPresentationStyle = .fullScreen
                   let centerNavVC = UINavigationController(rootViewController: centerVC)
                   panel!.center(centerNavVC)
            
               } else if indexPath.row == 3 {
                             
                             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                 let centerVC: UIViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
                                 centerVC.modalPresentationStyle = .fullScreen
                                 let centerNavVC = UINavigationController(rootViewController: centerVC)
                                 panel!.center(centerNavVC)
            
            } else if indexPath.row == 4 {
                                        
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let centerVC: UIViewController = storyBoard.instantiateViewController(withIdentifier: "CartVC") as! CartVC
                                centerVC.modalPresentationStyle = .fullScreen
                                let centerNavVC = UINavigationController(rootViewController: centerVC)
                                panel!.center(centerNavVC)
            
            } else if indexPath.row == 5 {
                    
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let centerVC: UIViewController = storyBoard.instantiateViewController(withIdentifier: "CategoriesVC") as! CategoriesVC
            centerVC.modalPresentationStyle = .fullScreen
            let centerNavVC = UINavigationController(rootViewController: centerVC)
            panel!.center(centerNavVC)
            
            } else if indexPath.row == 6 {
            
                      shareApp()
                     
           
            
           } else {
               print("Error")
           }
       }
  
    @IBAction func logOutAction(_ sender: Any) {
           
           Helper.Saveuser_id(user_id: nil)
           Helper.Saveuser_Email(email: nil)
           Helper.Saveuser_namen(name: nil)
           Helper.Saveuser_Image(image: nil)
           
           Helper.restartApp("LoginVC")
        }
    func shareApp(){
        let AppIdOnAppStore = 1510132418
        let firstActivityItem = ""
        let secondActivityItem : NSURL = NSURL(string: "https://apps.apple.com/eg/app/Brands/id\(AppIdOnAppStore)")!
        let image : UIImage = #imageLiteral(resourceName: "ic_check_mark_green")
        let activityViewController : UIActivityViewController = UIActivityViewController(
        activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView =  UIButton()
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}
