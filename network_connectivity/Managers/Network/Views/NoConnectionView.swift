//
//  NoConnectionView.swift
//  dressed
//
//  Created by Salvatore D'Agostino on 2015-02-28.
//  Copyright (c) 2015 dressed inc. All rights reserved.
//

import UIKit

class NoConnectionView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        let screenSize : CGRect = UIScreen.mainScreen().bounds
        let label = UILabel(frame: CGRectMake(0, 0, screenSize.width, 200))
        label.numberOfLines = 2;
        label.text = "Oops, we seem to have lost the interwebs, " +
        "\n please re-connect and try again"

        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center;
        self.addSubview(label)
        self.backgroundColor = UIColor.blackColor()
        self.alpha = 0.7
    }
}

