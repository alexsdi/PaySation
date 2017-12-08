//
//  TCellServerList.swift
//  PayStation
//
//  Created by Saravanan on 29/11/17.
//  Copyright © 2017 SDI. All rights reserved.
//

import UIKit

class TCellServerList: UITableViewCell {

    @IBOutlet weak var lblIPAddress: UILabel!
    @IBOutlet weak var lblServerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
