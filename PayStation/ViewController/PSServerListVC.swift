//
//  PSServerListVC.swift
//  PayStation
//
//  Created by Saravanan on 29/11/17.
//  Copyright © 2017 SDI. All rights reserved.
//

import UIKit

class PSServerListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var txtDeviceName: UITextField!
    @IBOutlet weak var tblVwServerList: UITableView!
    @IBOutlet weak var vwName: UIView!
    @IBOutlet weak var vwServerList: UIView!
    @IBOutlet weak var vwOverLay: UIView!
    
    var arrServerList : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwOverLay.backgroundColor = UIColor(hue: 1, saturation: 1, brightness: 0, alpha: 0.7)
        arrServerList = NSMutableArray()
        tblVwServerList.tableFooterView = UIView()
        
        getServerList()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vwName.isHidden = true
        vwServerList.isHidden = false
        
    }
    func getServerList(){
        let arrSeverName = ["Server 1","Server 2","Server 3","Server 4"]
        let arrIpAddress = ["198.105.15.1","198.105.15.1","198.105.15.1","198.105.15.1"]
        
        for index in 0..<arrSeverName.count {
      
            let dictServer = NSMutableDictionary()
            dictServer.setValue(arrSeverName[index], forKey: "serverName")
            dictServer.setValue(arrIpAddress[index], forKey: "ipAddress")
            
            arrServerList.add(dictServer)
            
        }
        tblVwServerList.reloadData()
    }
    @IBAction func onSave(_ sender: Any) {
         self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func onSkip(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      
        return arrServerList.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "TCellServerList") as? TCellServerList
        
        let dictSever = arrServerList[indexPath.row] as! NSMutableDictionary
        
        
        cell?.lblServerName.text = dictSever["serverName"] as? String
        cell?.lblIPAddress.text = dictSever["ipAddress"] as? String
       
        return cell!
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        UIView.transition(with: vwServerList, duration: 0.4, options: .transitionCurlUp, animations: {
            self.vwServerList.isHidden = true
            
        }) { (sucess) in
            
            UIView.transition(with: self.vwName, duration: 0.4, options: .transitionCurlDown, animations: {
                self.vwName.isHidden = false
            }) { (sucess) in
               
            }

        }
        
        
      //  vwName.isHidden = false
      //  vwServerList.isHidden = true
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
