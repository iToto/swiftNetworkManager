//
//  NetworkManager.swift
//  network_connectivity
//
//  Created by Salvatore D'Agostino on 2015-03-01.
//  Copyright (c) 2015 dressed. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager : NSObject {
    let networkLossNotification = "com.dressed.networkLossNotification"
    let networkFoundNotification = "com.dressed.networkFoundNotification"
    var hasConnection = false;
    
    /// Singleton
    class var sharedInstance: NetworkManager {
        struct Static {
            static var instance: NetworkManager? = nil
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = NetworkManager()
        }
        
        return Static.instance!
    }
    
    /// Checks internet connectivity every 2 seconds. When failed, it posts
    /// a notification that internet has been lost. When the internet connection
    /// returns, it will post a new notification that connection has returned.
    func startNetworkMonitor(){
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "checkConnection", userInfo: nil, repeats: true)
    }
    
    func checkConnection() {
        var notificationError:NSError?
        
        if !IJReachability.isConnectedToNetwork() {
            if self.hasConnection {
                self.hasConnection = false
                NSLog("Internet Connection Lost!")
                self.displayAlert()
            }

        } else {
            if !self.hasConnection {
                self.hasConnection = true
                NSLog("Internet Connection Found!")
            } else {
                NSLog("Internet Connection Active")
            }
        }
    }
    
    func displayAlert(){
        let alertController = UIAlertController(
            title: "Internet Connection Lost",
            message: "Oops, it seems we lost the interwebs. We need the internet to continue.",
            preferredStyle: .Alert)
        
        let action = UIAlertAction(
            title: "Retry",
            style: .Default,
            handler: {(alert: UIAlertAction!) in
                self.hasConnection = true
        })
        alertController.addAction(action)
        
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        delegate.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
    }
}
