//
//  TabBar.swift
//  iOSApp
//
//  Created by Ahmed kamal on 8/30/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class TabBar: UITabBarController ,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tabBar.items![1].badgeValue = "1"
         self.tabBarItem.badgeColor = UIColor.red
        
      selectedIndex = 0

        let nc = NotificationCenter.default
              
        
              nc.addObserver(self, selector: #selector(segue), name: Notification.Name("TheAdd"), object: nil)
              
        
//        setShadow(view: tabBar, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
//
        
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = #imageLiteral(resourceName: "home-1").withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.selectedImage = #imageLiteral(resourceName: "home-1").withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
   
        
                  
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = #imageLiteral(resourceName: "fav_black").withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = #imageLiteral(resourceName: "fav_black-1").withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
      
        

        let myTabBarItem4 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem4.image = nil
        
              
             
        let myTabBarItem5 = (self.tabBar.items?[3])! as UITabBarItem
        myTabBarItem5.image = #imageLiteral(resourceName: "Categories").imageWithColor(color1: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)).withRenderingMode(.alwaysOriginal)
        myTabBarItem5.selectedImage = #imageLiteral(resourceName: "Categories").withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
       let myTabBarItem6 = (self.tabBar.items?[4])! as UITabBarItem
        myTabBarItem6.image = #imageLiteral(resourceName: "profile").imageWithColor(color1: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)).withRenderingMode(.alwaysOriginal)
             myTabBarItem6.selectedImage = #imageLiteral(resourceName: "profile").withRenderingMode(UIImage.RenderingMode.alwaysOriginal)

       
        self.delegate = self

      
        
    tabBar.layer.cornerRadius = 35
    tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
                      

        // Do any additional setup after loading the view.
    }
    
     @objc func segue(){
        
      self.selectedIndex = 2
            
        }

}

