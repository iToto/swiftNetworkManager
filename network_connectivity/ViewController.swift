//
//  ViewController.swift
//  network_connectivity
//
//  Created by Salvatore D'Agostino on 2015-03-01.
//  Copyright (c) 2015 dressed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let networkManager:NetworkManager = NetworkManager()
    let networkLossNotification = "com.dressed.networkLossNotification"
    let networkFoundNotification = "com.dressed.networkFoundNotification"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.networkManager.startNetworkMonitor()
        
        // Register observer for network lost
        NSNotificationCenter.defaultCenter().addObserverForName(self.networkLossNotification,object:nil , queue:nil){ _ in
            self.displayNoConnectionView()
        }
        
        // Register observer for network found
        NSNotificationCenter.defaultCenter().addObserverForName(self.networkFoundNotification,object:nil , queue:nil){ _ in
            self.hideNoConnectionView()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testConnectivity() {
        if IJReachability.isConnectedToNetwork() {
            // Animate fade-in of view
            self.displayNoConnectionView()
        }
    }
    
    func displayNoConnectionView() {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let noConnectionView = NoConnectionView(frame: screenSize)
        noConnectionView.alpha = 0

        //code to animate bg with delay 2 and after completion it recursively calling animateImage method
        UIView.animateWithDuration(0.5, delay: 0, options:UIViewAnimationOptions.CurveEaseOut, animations: {() in
            noConnectionView.alpha = 0.8
            }, completion: nil)
        
        
        self.view.addSubview(noConnectionView)
    }
    
    func hideNoConnectionView() {
        NSLog("Remove no connection view")
        self.view.removeFromSuperview()
    }


}

