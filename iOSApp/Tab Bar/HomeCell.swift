//
//  HomeCell.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var AddFavourite : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func btnFav(_ sender: UIButton) {
         AddFavourite?()
//         if Helper.getaUser_id() == nil  {
//            btnFav.isSelected = false
//
//         } else {
//             btnFav.isSelected = true
//        }
       
       
    }
}
