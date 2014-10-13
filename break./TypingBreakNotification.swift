//
//  TypingBreakNotification.swift
//  break.
//
//  Created by Andrew Clissold on 10/13/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

class TypingBreakNotification: UILocalNotification {

    init(date: NSDate) {
        super.init()

        self.fireDate = date
        self.timeZone = NSTimeZone.defaultTimeZone()
        self.repeatInterval = Settings.repeat
        self.alertBody = "It's time for your typing break!"
        self.soundName = UILocalNotificationDefaultSoundName
        if self.respondsToSelector("setCategory:") { self.category = snooze }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
