//
//  TCellCheckList.swift
//  PayStation
//
//  Created by Saravanan on 28/11/17.
//  Copyright © 2017 SDI. All rights reserved.
//

import UIKit

class TCellCheckList: UITableViewCell {

    @IBOutlet weak var lblBidAmount: UILabel!
    @IBOutlet weak var lblIdNum: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
