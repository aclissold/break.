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

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func silenceSwitchToggled(value: Bool) {
        userDefaults.setBool(value, forKey: "silence")
    }
}
