//
//  AppDelegate.swift
//  PayStation
//
//  Created by Saravanan on 28/11/17.
//  Copyright © 2017 SDI. All rights reserved.
//


//Font Family Name = [AvantGarde Bk BT]
//Font Names = [["AvantGardeITCbyBT-Book"]]

//Font Family Name = [AvantGarde Md BT]
//Font Names = [["AvantGardeITCbyBT-Medium"]]
import UIKit
import SquarePointOfSaleSDK
import Foundation
import MessageUI
import MMDrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MFMailComposeViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.statusBarStyle = .lightContent

        UINavigationBar.appearance().barTintColor = UIColorFromRGB(rgbValue: 0x04A0A9)
        UINavigationBar.appearance().tintColor = UIColor.white
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font : UIFont(name: "AvantGardeITCbyBT-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18)]
        
        
       
        return true
    }

    
    func makePayment(userInfo : String){

        let isSquareAppInstalled = UIApplication.shared.canOpenURL(URL.init(string: "square-commerce-v1://")!)
        if !isSquareAppInstalled
        {
            print("Square app not installed")
            let alertView = UIAlertController.init(title: "App not installed!", message: "\"Point of Sale\" App is not installed in on your device ", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction.init(title: "Install", style: UIAlertActionStyle.default, handler: { (alertview) in
                
            }))
            alertView.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (alertview) in
                
            }))
            self.window?.rootViewController?.present(alertView, animated: true, completion: nil)
            return;
        }
        print("Square app  installed")
        // Replace with your app's URL scheme.
        let callbackURL = URL(string: "PayStation://")!
        
        // Your client ID is the same as your Square Application ID.
        // Note: You only need to set your client ID once, before creating your first request.
        SCCAPIRequest.setClientID("sq0idp-BdDVP0ixlR04pEk_BCqJ1Q")
        
        
        do {
            // Specify the amount of money to charge.
            let money = try SCCMoney(amountCents: 0, currencyCode: "USD")
            
            // Create the request.
            let apiRequest =
                try SCCAPIRequest(
                    callbackURL: callbackURL,
                    amount: money,
                    userInfoString: userInfo,
                    locationID: nil,
                    notes: "Bidding",
                    customerID: nil,
                    supportedTenderTypes: .all,
                    clearsDefaultFees: false,
                    returnAutomaticallyAfterPayment: false
            )
            
            // Open Point of Sale to complete the payment.
            try SCCAPIConnection.perform(apiRequest)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
    }
    func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName )
            print("Font Names = [\(names)]")
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let sourceApplication = options[.sourceApplication] as? String,
            sourceApplication.hasPrefix("com.squareup.square") else {
                return false
        }
        
        do {
            let response = try SCCAPIResponse(responseURL: url)
            
            if let error = response.error {
                // Handle a failed request.
                
                sendMail(msg: error.localizedDescription)
                print(error.localizedDescription)
            } else {
                // Handle a successful request.
            }
            
        } catch let error as NSError {
            // Handle unexpected errors.
            print(error.localizedDescription)
            sendMail(msg: error.localizedDescription)
        }
        
        return true
    }
    
     public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
     {
        appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func sendMail(msg: String){
        
        if(MFMailComposeViewController.canSendMail()){
            
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.setToRecipients(["alex@sdi.la"])
            
            composeVC.setSubject("Point of scale message")
            composeVC.setMessageBody(msg, isHTML: false)
            
            
            
            // Present the view controller modally.
            
          appDelegate.window?.rootViewController?.present(composeVC, animated: true, completion: nil)
            
        }
       

         
    
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

