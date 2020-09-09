//
//  AddCell.swift
//  iOSApp
//
//  Created by Ahmed kamal on 9/8/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class AddCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var deleteImage: UIButton!
    
    var DeleteFromGallery : (()->())?
    @IBAction func DeleteAction(_ sender: Any) {
         DeleteFromGallery?()
    }
}
