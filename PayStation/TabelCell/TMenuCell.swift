//
//  TMenuCell.swift
//  AuctionZoom
//
//  Created by Adnin on 19/11/17.
//  Copyright © 2017 Manikandan S. All rights reserved.
//

import UIKit

class TMenuCell: UITableViewCell {

    @IBOutlet weak var imgVwMenu: UIImageView!
    @IBOutlet weak var lblMenu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
