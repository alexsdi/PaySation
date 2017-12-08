//
//  PSLoginVc.swift
//  PayStation
//
//  Created by Saravanan on 28/11/17.
//  Copyright © 2017 SDI. All rights reserved.
//

import UIKit

class PSLoginVc: UIViewController {

    @IBOutlet weak var btnRemember: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        txtPassword.setLeftPaddingPoints(10)
        txtEmail.setLeftPaddingPoints(10)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func onRemember(_ sender: Any) {
        
    }
    @IBAction func onSignIn(_ sender: Any) {
        let pSCheckInVC = self.storyboard?.instantiateViewController(withIdentifier: "PSCheckInVC") as! PSCheckInVC
        pSCheckInVC.checkInType = 1
        self.navigationController?.pushViewController(pSCheckInVC, animated: true)
    }
    
 
    @IBAction func onForgotPassword(_ sender: Any) {
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
