//
//  TextModel.swift
//  PayStation
//
//  Created by Saravanan on 18/12/17.
//  Copyright © 2017 SDI. All rights reserved.
//

import UIKit
import AVFoundation

class TextModel: NSObject {
    
    var fieldType : String?
    var fieldLabel : String?
    var fieldMinVal : Int?
    var fieldMaxVal: Int?
    weak var contentView : TCellText?
    
    func setTblCell(cell : TCellText) -> Void
    {
        self.contentView = cell
        refreshContentView()
    }
    
    func refreshContentView() -> Void
    {
        if(self.contentView == nil)
        {
            return;
        }
        
        let cell : TCellText = self.contentView!
        cell.lblValue.text = fieldLabel
        cell.txtValue.placeholder = fieldLabel
        
        
    }
    
}
