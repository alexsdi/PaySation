//
//  AZMenuVC.swift
//  AuctionZoom
//
//  Created by Adnin on 19/11/17.
//  Copyright © 2017 Manikandan S. All rights reserved.
//

import UIKit

class AZMenuVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var tblMenu: UITableView!
    
    var arrMenu : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrMenu = NSMutableArray()
        
        let userName = "Hello John"
        let range = (userName as NSString).range(of: "Hello")
        
        let attributedString = NSMutableAttributedString(string: userName)
        attributedString.addAttributes([NSAttributedStringKey.foregroundColor: UIColorFromRGB(rgbValue: 0xE7F1F2), NSAttributedStringKey.font : UIFont(name: "TrebuchetMS", size: 20) ?? UIFont.systemFont(ofSize: 20)], range: range)
        
        lblUserName.attributedText = attributedString
        
        loadMenus()
        
        tblMenu.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- USER DEFINED METHODS
    func loadMenus()
    {
        let arrMenusName = [LSString(key: "TUTORIAL_MODE"), LSString(key: "CONTACT_US"), LSString(key: "SETTINGS"), LSString(key: "RATE_APP"), LSString(key: "CONNECT_BIDSTATION")]
        
        for i in 0..<arrMenusName.count
        {
            let dictMenu = NSMutableDictionary()
            dictMenu.setValue(arrMenusName[i], forKey: "menuName")
            dictMenu.setValue("settingsIcon", forKey: "menuImg")
            arrMenu?.add(dictMenu)
        }
        
        tblMenu.reloadData()
    }
    
    @IBAction func onProfile(_ sender: Any)
    {
        
    }
    
    func pushToVC(vwControllerNme : String)
    {
      
      
    }
    
    //MARK:- TABLEVIEW DATA SOURCE AND DELEGATE METHODS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMenu!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TMenuCell") as? TMenuCell
        
        let dictMenu = arrMenu?.object(at: indexPath.row) as? NSDictionary
        cell?.lblMenu.text = dictMenu?.value(forKey: "menuName") as? String
        
        let imageName = dictMenu?.value(forKey: "menuImg") as? String
        cell?.imgVwMenu.image = UIImage(named: imageName!)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 49
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0
        {
            //Tutorial Mode
            pushToVC(vwControllerNme: "AZPayStationVC")
        }
        else if indexPath.row == 1
        {
            //Contact Us
            pushToVC(vwControllerNme: "AMContactUs")
        }
        else if indexPath.row == 2
        {
            //Settings
            pushToVC(vwControllerNme: "AZSettingVC")
        }
        else if indexPath.row == 3
        {
        }
        else
        {
         
        }
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
