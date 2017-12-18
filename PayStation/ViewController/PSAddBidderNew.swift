//
//  PSAddBidderNew.swift
//  PayStation
//
//  Created by Saravanan on 18/12/17.
//  Copyright © 2017 SDI. All rights reserved.
//

import UIKit

class PSAddBidderNew: UIViewController,UITableViewDelegate,UITableViewDataSource,TPKeyboardAvoidingScrollViewDelege {

    @IBOutlet weak var consHghtSaveSkip: NSLayoutConstraint!
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var scrollVw: TPKeyboardAvoidingScrollView!
    
    var arrFields : [TextModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrFields = [TextModel]()
        scrollVw.dele = self
        
        getFieldStructure()
        // Do any additional setup after loading the view.
    }

    
    func getFieldStructure(){
        
        let arrType = ["1","2","3"]
        let arrLblvalue = ["Name","Email","Bidder #"]
        let arrMinVal = [1,3,3]
        let arrMaxVal = [30,50,6]
        
        for i in 0..<arrLblvalue.count{
            
            let textModel = TextModel()
            
            textModel.fieldType = arrType[i]
            textModel.fieldLabel = arrLblvalue[i]
            textModel.fieldMinVal = arrMinVal[i]
            textModel.fieldMaxVal = arrMaxVal[i]
  
            arrFields.append(textModel)
            
            
        }
        
        tblVw.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblVw.reloadData()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //Text Field Delegates
    func textFieldDidEndEditing(_ textField: UITextField!) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField!) {
        
        
    }
    func textField(_ textField: UITextField!, shouldChangeCharactersIn range: NSRange, replacementString string: String!) -> Bool {
        
        var maxLength = 100
        let textModel = arrFields[textField.tag]
        
        if let maxL = textModel.fieldMaxVal{
            maxLength = maxL
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        if(textModel.fieldType == "3"){
            let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
            return newString.length <= maxLength && string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
        }

        return newString.length <= maxLength
        
        
       // return true
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrFields.count
        
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let textModel = arrFields[indexPath.row]
        var cell : TCellText?
        
        if textModel.contentView == nil
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "TCellText") as? TCellText
            cell?.txtValue.tag = indexPath.row
            textModel.setTblCell(cell: cell!)
            
        }
        else
        {
            cell = textModel.contentView
            textModel.refreshContentView()
        }
        
       
        return cell!
        
    }
    
    
    func valiateFields()-> Bool{
        
        for txtModel in arrFields{
            
            if let charCount = txtModel.contentView?.txtValue.text?.trim().characters.count{
                let charCnt = Int(charCount)
                if(charCnt == 0){
                    txtModel.contentView?.txtValue.placeHolderColor = UIColor.red
                    return false
                }
                
                if(charCnt < txtModel.fieldMinVal!){
                    
                    let msg = txtModel.fieldLabel! + " should be minimum \(txtModel.fieldMinVal!) character"
                    appDelegate.showAlert(message: msg)
                    return false
                }
                
                if(txtModel.fieldType == "2"){
                    if(txtModel.contentView?.txtValue.text?.isValidEmail() == false){
                        appDelegate.showAlert(message: "Please enter valid Email Id")
                        return false
                    }
                }
            }

        }
        
        return true
    }
    
    @IBAction func onSkip_Swipe(_ sender: Any) {
        if(valiateFields() == true){
            
        }
    }
    
    @IBAction func onSave_Swipe(_ sender: Any) {
        if(valiateFields() == true){
            
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
