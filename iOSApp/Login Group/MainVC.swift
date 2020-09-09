
//
//  mainTabbarVC.swift
//  DemoProject
//
//  Created by Ahmed kamal on 3/23/20.
//  Copyright © 2020 Ahmed kamal. All rights reserved.
//

import UIKit

extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}


import UIKit

import Foundation

class MainTabBar : UITabBar {

    private var middleButton = UIButton()

    override func awakeFromNib() {
       
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.setupMiddleButton()
            
          
            
        }
    }
    

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden {
            return super.hitTest(point, with: event)
        }
        
        let from = point
        let to = middleButton.center

        return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)) <= 39 ? middleButton : super.hitTest(point, with: event)
    }

    func setupMiddleButton() {
        middleButton.frame.size = CGSize(width: 78, height: 78)
        middleButton.backgroundColor = .clear
        middleButton.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        middleButton.layer.cornerRadius = 39
        middleButton.layer.masksToBounds = true
        middleButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
        middleButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        addSubview(middleButton)
//        self.layer.cornerRadius = 40
//        self.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        self.borderWidth = 1
    }

    @objc func test() {
        print("my name is jeff")
        
                 let nc = NotificationCenter.default
                 nc.post(name: Notification.Name("TheAdd"), object: nil)
                   
            
        
    }
}
