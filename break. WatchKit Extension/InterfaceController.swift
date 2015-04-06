//
//  InterfaceController.swift
//  break. WatchKit Extension
//
//  Created by Andrew Clissold on 4/4/15.
//  Copyright (c) 2015 Andrew Clissold. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var silenceSwitch: WKInterfaceSwitch!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let silence = userDefaults.boolForKey("silence")
        silenceSwitch.setOn(silence)
    }

    @IBAction func silenceSwitchToggled(value: Bool) {
        userDefaults.setBool(value, forKey: "silence")
        userDefaults.synchronize()

        WKInterfaceController.openParentApplication(["silence": value], reply: nil)
    }
}
