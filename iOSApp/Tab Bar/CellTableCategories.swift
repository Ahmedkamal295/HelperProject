//
//  CellTableCategories.swift
//  iOSApp
//
//  Created by Ahmed kamal on 9/2/20.
//  Copyright © 2020 Khaled Ghoniem. All rights reserved.
//

import UIKit

class CellTableCategories: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStore: UILabel!
    @IBOutlet weak var lblDescribtaion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
