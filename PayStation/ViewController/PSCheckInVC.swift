//
//  PSCheckInVC.swift
//  PayStation
//
//  Created by Saravanan on 28/11/17.
//  Copyright © 2017 SDI. All rights reserved.
//

import UIKit

class PSCheckInVC: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating {

    @IBOutlet weak var btnAddBidder: UIBarButtonItem!
    @IBOutlet weak var btnSync: UIButton!
    
    
    @IBOutlet weak var tblVw: UITableView!
    
    var checkInType : Int!
    
    var arrAttendanceList = [String: AnyObject]()
    var arrAttendanceDict = NSMutableArray()
    
    var sortedKeys = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblVw.delegate = self
        tblVw.dataSource = self
        
        let barButtonBackStr = "+ Bidder"
        
        let attributedBarButtonBackStr = NSMutableAttributedString(string: barButtonBackStr as String)
        
        attributedBarButtonBackStr.addAttribute(NSAttributedStringKey.font,
                                                value: UIFont(
                                                    name: "AvantGardeITCbyBT-Medium",
                                                    size: 18.0)!,
                                                range: NSRange(
                                                    location:0,
                                                    length:barButtonBackStr.characters.count))
        
        attributedBarButtonBackStr.addAttribute(NSAttributedStringKey.font,
                                                value: UIFont(
                                                    name: "AvantGardeITCbyBT-Medium",
                                                    size: 24.0)!,
                                                range: NSRange(
                                                    location:0,
                                                    length:1))
        let label = UILabel()
        label.textColor = UIColor.white
        label.attributedText = attributedBarButtonBackStr
        label.sizeToFit()
        
      //  btnAddBidder.customView = label

        
        loadAttendanceList()
        
        
        tblVw.sectionIndexColor = UIColor.lightGray
        tblVw.sectionIndexBackgroundColor = UIColor.clear
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        /*
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            
        } else {
            tblVw.tableHeaderView = searchController.searchBar
        }
        */
        tblVw.tableHeaderView = searchController.searchBar
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
       
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
    //Search text
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            arrAttendanceList.removeAll()
            let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
            let arrFilter = self.arrAttendanceDict.filtered(using: predicate)
            let arrFilterValue = NSMutableArray(array: arrFilter)
            setAlphaptes(arrVal: arrFilterValue)
        } else {
            loadAttendanceList()
        }
        
        
    }
    @IBAction func onSyncWithPayStation(_ sender: Any) {
    }
    
    
    
    func loadAttendanceList()
    {
        
        if(arrAttendanceDict.count > 0){
            arrAttendanceDict.removeAllObjects()
        }
  

        for dict in appDelegate.arrBidder{
            
             arrAttendanceDict.add(dict)
            
        }
        
        arrAttendanceList.removeAll()
        setAlphaptes(arrVal: arrAttendanceDict)
        
    }
    
    func setAlphaptes(arrVal : NSMutableArray){
        
        for i in 0..<arrVal.count
        {
            let dict = arrVal.object(at: i) as? NSDictionary
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
       // let addBidVc = self.storyboard?.instantiateViewController(withIdentifier: "PSAddBidderNew") as! PSAddBidderNew
        
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

        let cell = tableView.dequeueReusableCell(withIdentifier: "TCellCheckList") as? TCellCheckList
        let arrAttendance = arrAttendanceList[sortedKeys[indexPath.section]] as? NSArray
        let dictAttendance = arrAttendance?.object(at: indexPath.row) as? NSMutableDictionary
        cell?.lblBidAmount.text = ""
        
        if(checkInType == 2){
            
            if let amount = dictAttendance?.value(forKey: "amount") as? String{
                cell?.lblBidAmount.text = "$\(amount)"
            }
          
        }
        cell?.lblName.text = dictAttendance?.value(forKey: "name") as? String
        cell?.lblIdNum.text = dictAttendance?.value(forKey: "id") as? String

        return cell!

    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.searchBar.text = ""
        self.searchController.isActive = false
        
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

