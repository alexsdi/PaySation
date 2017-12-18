//
//  PSAddBidder.swift
//  PayStation
//
//  Created by Saravanan on 29/11/17.
//  Copyright © 2017 SDI. All rights reserved.
//

import UIKit

class PSAddBidder: UIViewController,TPKeyboardAvoidingScrollViewDelege {

    @IBOutlet weak var txtBidder: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    var bidderType : Int!
    var dictBidderObj : NSMutableDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(bidderType == 1){
            setBorderSytle(isNew: true)
            self.title = "Add Bidder"
        }else{
         setBorderSytle(isNew: false)
            self.title = "Check In"

                if(dictBidderObj != nil){
                    
                    txtName.text = dictBidderObj?.value(forKey: "name") as? String
                    txtBidder.text = dictBidderObj?.value(forKey: "id") as? String
                    txtEmail.text = dictBidderObj?.value(forKey: "email") as? String
                }
 
        }
        
    }

    func setBorderSytle(isNew : Bool){
        
        if(isNew == true){
            txtBidder.borderStyle = .roundedRect
            txtName.borderStyle = .roundedRect
            txtEmail.borderStyle = .roundedRect
        }else{
            txtBidder.borderStyle = .none
            txtName.borderStyle = .none
            txtEmail.borderStyle = .none
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onSaveSkip(_ sender: Any) {
        
        if(validateFileds() == true){
            
            if(bidderType == 1){
                let dictBidder = NSMutableDictionary()
                dictBidder.setValue(txtName.text, forKey: "name")
                dictBidder.setValue(txtBidder.text, forKey: "id")
                dictBidder.setValue(txtEmail.text, forKey: "email")
                appDelegate.arrBidder.add(dictBidder)
            }else{
                
                dictBidderObj?.setValue(txtName.text?.trim(), forKey: "name")
                dictBidderObj?.setValue(txtBidder.text?.trim(), forKey: "id")
                dictBidderObj?.setValue(txtEmail.text?.trim(), forKey: "email")
  
            }
            
            appDelegate.saveBidderList()
            self.navigationController?.popViewController(animated: true)
        }

    }
    
    @IBAction func onSaveSwipe(_ sender: Any) {
        
         if(validateFileds() == true){
            if(bidderType == 1){
                let dictBidder = NSMutableDictionary()
                dictBidder.setValue(txtName.text, forKey: "name")
                dictBidder.setValue(txtBidder.text, forKey: "id")
                dictBidder.setValue(txtEmail.text, forKey: "email")
                appDelegate.arrBidder.add(dictBidder)
            }else{
                
                dictBidderObj?.setValue(txtName.text?.trim(), forKey: "name")
                dictBidderObj?.setValue(txtBidder.text?.trim(), forKey: "id")
                dictBidderObj?.setValue(txtEmail.text?.trim(), forKey: "email")
                
            }
     
        appDelegate.saveBidderList()
        
        //Check point of scale insall or not
            
       // appDelegate.makePayment(userInfo: "TestId")
        self.navigationController?.popViewController(animated: true)
        }

    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func textField(_ textField: UITextField!, shouldChangeCharactersIn range: NSRange, replacementString string: String!) -> Bool {
        
        return true
        
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
