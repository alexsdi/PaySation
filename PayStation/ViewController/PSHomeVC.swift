//
//  PSHomeVC.swift
//  PayStation
//
//  Created by Saravanan on 28/11/17.
//  Copyright © 2017 SDI. All rights reserved.
//

import UIKit
import MMDrawerController
class PSHomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSelectServer(_ sender: Any) {
        
        let pSServerListVC = self.storyboard?.instantiateViewController(withIdentifier: "PSServerListVC") as! PSServerListVC
        self.navigationController?.present(pSServerListVC, animated: false, completion: nil)
        
        
    }
    @IBAction func onmenu(_ sender: Any) {
        
       // self.mm_drawerController.toggle(.left, animated: true, completion: nil)
        
    }
    
    @IBAction func onCheckIn(_ sender: Any) {
        
        let pSCheckInVC = self.storyboard?.instantiateViewController(withIdentifier: "PSCheckInVC") as! PSCheckInVC
        pSCheckInVC.checkInType = 1
        self.navigationController?.pushViewController(pSCheckInVC, animated: true)
        
    }
    @IBAction func onSynchBidStation(_ sender: Any) {
        
        let pSCheckInVC = self.storyboard?.instantiateViewController(withIdentifier: "PSLoginVc") as! PSLoginVc
        self.navigationController?.pushViewController(pSCheckInVC, animated: true)
        
    }

    @IBAction func onCheckOut(_ sender: Any) {
        let pSCheckInVC = self.storyboard?.instantiateViewController(withIdentifier: "PSCheckInVC") as! PSCheckInVC
        pSCheckInVC.checkInType = 2
        self.navigationController?.pushViewController(pSCheckInVC, animated: true)
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
