//
//  Constant.swift
//  AuctionZoom
//
//  Created by Adnin on 18/11/17.
//  Copyright © 2017 Manikandan S. All rights reserved.
//

import Foundation
import UIKit
import MMDrawerController

let storyBoard = UIStoryboard(name: "Main", bundle:nil)
let appDelegate = UIApplication.shared.delegate as! AppDelegate

/**** RGB Color ***/

func UIColorFromRGB(rgbValue: UInt) -> UIColor
{
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

/*** Language Localizable ***/

func LSString(key: String) -> String
{
    return NSLocalizedString(key, comment: "")
}

//MARK:- EXTENSIONS

extension UITextField
{
    func setBorderColorAndLeftViewMode()
    {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = leftView
        self.leftViewMode = UITextFieldViewMode.always
        self.layer.borderColor = UIColorFromRGB(rgbValue: 0xf5f5f5).cgColor
        
        self.rightView = leftView
        self.rightViewMode = UITextFieldViewMode.always
        
        self.layer.borderWidth = 1.0
    }
}

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

//MARK:- Border - Colors
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
//MARK:- MENU DRAWER METHODS


func loadMenuPage()
{
    let slideMenuVC = storyBoard.instantiateViewController(withIdentifier: "AZMenuVC") as? AZMenuVC
    
    let homeVC = storyBoard.instantiateViewController(withIdentifier: "PSHomeVC") as? PSHomeVC
    
    let nav = UINavigationController(rootViewController: homeVC!)
    
    let drawerController = MMDrawerController(center: nav, leftDrawerViewController: slideMenuVC, rightDrawerViewController: nil)
    drawerController?.showsShadow = false
    
    
    drawerController?.maximumLeftDrawerWidth = UIScreen.main.bounds.size.width - 40
    drawerController?.centerHiddenInteractionMode = .full
    drawerController?.closeDrawerGestureModeMask = .all
    appDelegate.window?.rootViewController = drawerController
    appDelegate.window?.makeKeyAndVisible()
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count)) != nil
    }
}

extension UISearchBar {
    
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
}


