//
//  Constant.swift
//  DemoProject
//
//  Created by MOHAB on 2/29/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

let arabicLang = "ar"
let englishLang = "en"

let Authontication = "Authontication"
let SideMenue = "SideMenue"
let Landing = "Landing"
let Wallet = "Wallet"
let Setting = "Setting"
let PopView = "PopView"
let SocketURL = "http://awasalek.mo7taref.com:3010"
let ApiURL = "https://www.awaselak.com/api/"
let GoogleKey = "AIzaSyCwOy-NiunTQ7Q8D_d6eCUAeX2caw6oqQ0"
let Notification_carType = "select_cartype"
let Notification_InitialPrice = "InitialPrice"
let Notification_endReason = "choose_EndReason"
let Notification_accept_trip = "accept_trip"
let Notification_finish_trip = "finish_trip"

let Notification_Determine_time = "Determine_Time"
let Currency = "R.S".localized





let appDelegate = UIApplication.shared.delegate as! AppDelegate
let appscene = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate

import UIKit

enum storyBoardName: String {
    case authentication = "Authentication"
    case landing = "Landing"
    case menu = "Menu"
}

enum storyBoardVCIDs: String {
    case IntroVC = "IntroVC"
    case signUp = "signUpVc"
    case home = "HomeVC"
    case login = "LoginVC"
    case settings = "SettingsVC"
    case Logout = "logout"
    case contactUsVc = "contactUsVc"
    case termsAndConditionVc = "termsAndConditionVc"
    case SideMenueVC = "SideMenueVC"
    case SendComplianceVC = "SendComplianceVC"
}
extension UIStoryboard {
    class func instantiateInitialViewController(_ board: storyBoardName) -> UIViewController {
        let story = UIStoryboard(name: board.rawValue, bundle: nil)
        return story.instantiateInitialViewController()!
    }
}
