//
//  SceneDelegate.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit
import FAPanels
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if Helper.getaUser_id() != nil {
                   
                   SideMenu()
                  
               }
        guard let _ = (scene as? UIWindowScene) else { return }
        
        //L102Localizer.DoTheMagic()
    }
    func SideMenu(){
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             
              let SideMenueStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             
                //        let leftMenuVC: MenueVC = mainStoryboard.instantiateViewController(withIdentifier: "LeftMenuVC") as! MenueVC
                let rightMenuVC: SideMenueVc = SideMenueStoryboard.instantiateViewController(withIdentifier: "SideMenueVc")  as! SideMenueVc
                let HomeVc = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC")
                let PanelController: FAPanelController = FAPanelController()
                if L102Language.currentAppleLanguage() == "ar" {
                    
                   PanelController.right(rightMenuVC).center(HomeVc)
                }else {
                  PanelController.left(rightMenuVC).center(HomeVc)
                    
                    
                }
                
                window?.rootViewController = PanelController
                window?.makeKeyAndVisible()
            }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

