//
//  MyFavouritsCell.swift
//  iOSApp
//
//  Created by Khaled Ghoniem on 8/24/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class MyFavouritsCell: UICollectionViewCell {
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
  
 var DeleteFavourite : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
     @IBAction func btnUnFav(_ sender: Any) {
             DeleteFavourite?()
        }
        @IBAction func btnCart(_ sender: Any) {
        }
    }
    

