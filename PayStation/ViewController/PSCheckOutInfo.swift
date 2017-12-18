//
//  PSCheckOutInfo.swift
//  PayStation
//
//  Created by Saravanan on 30/11/17.
//  Copyright © 2017 SDI. All rights reserved.
//

import UIKit

class PSCheckOutInfo: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtBidder: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var dictBidderObj : NSMutableDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(dictBidderObj != nil){
            
            txtName.text = dictBidderObj?.value(forKey: "name") as? String
            txtAmount.text = dictBidderObj?.value(forKey: "amount") as? String
            txtBidder.text = dictBidderObj?.value(forKey: "id") as? String
            txtEmail.text = dictBidderObj?.value(forKey: "email") as? String
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func onSave(_ sender: Any) {
        
        if(validateFileds() == true){
            
            dictBidderObj?.setValue(txtName.text?.trim(), forKey: "name")
            dictBidderObj?.setValue(txtBidder.text?.trim(), forKey: "id")
            dictBidderObj?.setValue(txtEmail.text?.trim(), forKey: "email")
            dictBidderObj?.setValue(txtAmount.text?.trim(), forKey: "amount")
            
            appDelegate.saveBidderList()
            self.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    func validateFileds()->Bool{
        
        if(txtName.text?.trim().characters.count == 0){
            txtName.placeHolderColor = UIColor.red
            txtName.placeholder = "Enter name"
            return false
        }else if(txtEmail.text?.trim().characters.count == 0){
            txtEmail.placeHolderColor = UIColor.red
            txtEmail.placeholder = "Enter email"
            return false
        }else if(txtBidder.text?.trim().characters.count == 0){
            txtBidder.placeHolderColor = UIColor.red
            txtBidder.placeholder = "Enter bidder"
            return false
        }else if(txtAmount.text?.trim().characters.count == 0){
            txtAmount.placeHolderColor = UIColor.red
            txtAmount.placeholder = "Enter ammount"
            return false
        }else if(!((txtEmail.text?.isValidEmail())!)){
            appDelegate.showAlert(message: "Invalid Email Id")
            return false
        }
        
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
