//
//  TypingBreakNotification.swift
//  break.
//
//  Created by Andrew Clissold on 10/13/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

class TypingBreakNotification: UILocalNotification {

    init(date: NSDate, repeat: Bool) {
        super.init()

        fireDate = date
        timeZone = NSTimeZone.defaultTimeZone()
        if (repeat) {
            repeatInterval = .WeekCalendarUnit
        }
        alertBody = "It's time for your typing break!"
        soundName = UILocalNotificationDefaultSoundName
        if respondsToSelector("setCategory:") { category = snooze }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
