//
//  ChooseLanguagevc.swift
//  iOSApp
//
//  Created by Ahmed kamal on 9/6/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class ChooseLanguagevc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnEnglish(_ sender: Any) {
         //changeLanguage(vcId: .login)
      
       let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "LoginVC")
        nextvc.modalPresentationStyle = .fullScreen
        self.present(nextvc,animated: false,completion: nil)
    }
    
    
    @IBAction func btnArabic(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "LoginVC")
        nextvc.modalPresentationStyle = .fullScreen
        self.present(nextvc,animated: false,completion: nil)
    }
    
}
