//
//  TCellText.swift
//  PayStation
//
//  Created by Saravanan on 18/12/17.
//  Copyright © 2017 SDI. All rights reserved.
//

import UIKit

class TCellText: UITableViewCell {
    @IBOutlet weak var lblValue: UILabel!
    
    @IBOutlet weak var txtValue: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
