//
//  PSCheckInVC.swift
//  PayStation
//
//  Created by Saravanan on 28/11/17.
//  Copyright © 2017 SDI. All rights reserved.
//

import UIKit

class PSCheckInVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var btnAddBidder: UIBarButtonItem!
    @IBOutlet weak var btnSync: UIButton!
    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var tblVw: UITableView!
    
    var checkInType : Int!
    
    var arrAttendanceList = [String: AnyObject]()
    var sortedKeys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblVw.delegate = self
        tblVw.dataSource = self
        
        tblVw.sectionIndexColor = UIColor.lightGray
        tblVw.sectionIndexBackgroundColor = UIColor.clear
        
         loadAttendanceList()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(checkInType == 1){
            
           btnSync.isHidden =  true
            self.title = "Check In"
            
        }else{
            self.navigationItem.rightBarButtonItem = nil
             self.title = "Check Out"
        }
    }
    @IBAction func onSyncWithPayStation(_ sender: Any) {
    }
    func loadAttendanceList()
    {
        let arrNames = ["Ann Murphy", "Ashley Ruiz", "Britanny Garcia", "Bobby Hunt", "Brandon Chen", "Christine Hamilton", "Daniel Jackson", "Diana Harvey", "Garvy Mediana", "Gerald foster", "Hannah", "Yewande", "Zaheer"]
        
        let arrAttendanceDict = NSMutableArray()
        
        for i in 0..<arrNames.count
        {
            let dictAttendance = NSMutableDictionary()
            dictAttendance.setValue(arrNames[i], forKey: "name")
            dictAttendance.setValue("32154", forKey: "id")
            dictAttendance.setValue("alex@test.com", forKey: "email")
            if(i % 2 == 0){
                dictAttendance.setValue(false, forKey: "isSelect")
            }else{
                dictAttendance.setValue(true, forKey: "isSelect")

            }

            arrAttendanceDict.add(dictAttendance)
        }
        
        for i in 0..<arrAttendanceDict.count
        {
            let dict = arrAttendanceDict.object(at: i) as? NSDictionary
            let fullName = dict?.value(forKey: "name") as? String
            
            var key: String = "#"
            
            let firstChar = fullName!.characters.first?.description.uppercased()
            key = firstChar!
            
            var arrUsers = NSMutableArray()
            
            if let dictValue = arrAttendanceList[key]
            {
                let array = NSMutableArray()
                array.addObjects(from: dictValue as! [AnyObject])
                array.add(dict!)
                
                arrUsers = array
            }
            else
            {
                arrUsers.add(dict!)
            }
            
            arrAttendanceList[key] = arrUsers
        }
        
        self.sortedKeys = Array(self.arrAttendanceList.keys).sorted(by: <)
        
        tblVw.reloadData()
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: UITableViewScrollPosition.top, animated: false)
        return sortedKeys.index(of: title)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedKeys.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sortedKeys
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onAddBidder(_ sender: Any) {
        let addBidVc = self.storyboard?.instantiateViewController(withIdentifier: "PSAddBidder") as! PSAddBidder
        addBidVc.bidderType = 1
        self.navigationController?.pushViewController(addBidVc, animated: true)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let attendanceForSection = arrAttendanceList[sortedKeys[section]]
        {
            return attendanceForSection.count
        }
        
        return 0
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
       let cell = tableView.dequeueReusableCell(withIdentifier: "TCellCheckList") as? TCellCheckList
        
        let arrAttendance = arrAttendanceList[sortedKeys[indexPath.section]] as? NSArray
        let dictAttendance = arrAttendance?.object(at: indexPath.row) as? NSMutableDictionary
        
 
        let isSelect = dictAttendance?.value(forKey: "isSelect") as? Bool
        cell?.btnSelect.isSelected = false
        if isSelect == true
        {
            cell?.btnSelect.isSelected = true
        }
        cell?.lblBidAmount.text = ""
        
        if(checkInType == 2){
            
            cell?.lblBidAmount.text = "$1235"
            
        }
        cell?.lblName.text = dictAttendance?.value(forKey: "name") as? String
        cell?.lblIdNum.text = dictAttendance?.value(forKey: "id") as? String
        
        
        return cell!
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let arrAttendance = arrAttendanceList[sortedKeys[indexPath.section]] as? NSArray
        let dictAttendance = arrAttendance?.object(at: indexPath.row) as? NSMutableDictionary
        
        
        if(checkInType == 1){
            
            
            let pSAddBidder = self.storyboard?.instantiateViewController(withIdentifier: "PSAddBidder") as! PSAddBidder
            pSAddBidder.dictBidderObj = dictAttendance
            pSAddBidder.bidderType = 2
            self.navigationController?.pushViewController(pSAddBidder, animated: true)
            
        }else{
            
            let pSCheckOutInfo = self.storyboard?.instantiateViewController(withIdentifier: "PSCheckOutInfo") as! PSCheckOutInfo
            pSCheckOutInfo.dictBidderObj = dictAttendance
            self.navigationController?.pushViewController(pSCheckOutInfo, animated: true)
            
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
