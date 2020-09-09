//
//  CellCart.swift
//  iOSApp
//
//  Created by Ahmed kamal on 8/25/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class CellCart: UITableViewCell {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblNumber: UILabel!
    
    var DeleteCart : (()->())?
    
    var PlusCart : (()->())?
      var MinusCart : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnPlus(_ sender: Any) {
        
        PlusCart?()
    }
    @IBAction func btnMinus(_ sender: Any) {
        
        MinusCart?()
    }
    @IBAction func btnDelete(_ sender: Any) {
       DeleteCart?()
    }
    
}
