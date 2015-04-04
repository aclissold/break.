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

    let wormhole = MMWormhole(applicationGroupIdentifier: suiteName, optionalDirectory: "wormhole")

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let silence = userDefaults.boolForKey("silence")
        silenceSwitch.setOn(silence)
    }

    override func willActivate() {
        super.willActivate()

        wormhole.listenForMessageWithIdentifier("phoneDidUpdateSilence", listener: { (messageObject) in
            self.silenceSwitch.setOn(messageObject as Bool)
        })
    }

    @IBAction func silenceSwitchToggled(value: Bool) {
        wormhole.passMessageObject(value, identifier: "watchDidUpdateSilence")
        userDefaults.setBool(value, forKey: "silence")
        userDefaults.synchronize()
    }
}
