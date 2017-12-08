//
//  PSSquareConnectVC.swift
//  PayStation
//
//  Created by Saravanan on 01/12/17.
//  Copyright © 2017 SDI. All rights reserved.
//

import UIKit


class PSSquareConnectVC: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webVw: UIWebView!
    var activityView : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webVw.delegate = self
        webVw.loadRequest(URLRequest(url: URL(string: "https://connect.squareup.com/oauth2/authorize?client_id=sq0idp-BdDVP0ixlR04pEk_BCqJ1Q")!))
        
        showSpinner()
        
        activityView = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        let barButton : UIBarButtonItem = UIBarButtonItem.init(customView: activityView!)
        self.navigationItem.rightBarButtonItem = barButton
        activityView?.startAnimating()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        
        if request.url?.absoluteString.range(of: "callback") != nil{
            let queryItems = URLComponents(string: (request.url?.absoluteString)!)?.queryItems
            let code = queryItems?.filter({$0.name == "code"}).first
            
            
            loadMenuPage()
            
        }
        
        
        return true
        
    }
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
         stopSpinner()
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView){
        
        stopSpinner()
        
        
    }
    
    
    func stopSpinner(){
        activityView?.stopAnimating()
        //SwiftSpinner.hide()
        
    }
    func showSpinner(){
        
        activityView?.startAnimating()
        //SwiftSpinner.show(delay: 0.5, title: "Loading...", animated: true)
        
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
