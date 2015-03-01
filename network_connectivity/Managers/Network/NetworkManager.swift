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
    
    func testTimer() {
        NSLog("timer test")
    }
    
    func checkConnection() {
        var notificationError:NSError?
        if !IJReachability.isConnectedToNetwork() {
            NSLog("Internet Connection Lost!")

            // Notification
            let notification:NSNotification = NSNotification(name: self.networkLossNotification, object:notificationError)
            NSNotificationCenter.defaultCenter().postNotification(notification)
            connectionLost()
        } else {
            NSLog("Internet Connection Active")
        }
    }
    
    func connectionLost(){
        while (!IJReachability.isConnectedToNetwork()){
            NSLog("Still internet connection")
        }
        NSLog("Internet Connection Found!")
        var notificationError:NSError?
        // Notification
        let notification:NSNotification = NSNotification(name: self.networkFoundNotification, object:notificationError)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
}
