//
//  Settings.swift
//  break.
//
//  Created by Andrew Clissold on 7/19/14.
//  Copyright (c) 2014 Andrew Clissold. All rights reserved.
//

import Foundation
import UIKit

enum Frequency: Int {
    case Every20Minutes = 20
    case Every30Minutes = 30
    case Every60Minutes = 60
    case Every90Minutes = 90
}

struct Settings {
    static var silence:   Bool = userDefaults.boolForKey("silence")
    // begin ugly
    static var frequency: Frequency = Frequency(rawValue: userDefaults.integerForKey("frequency")) ?? .Every60Minutes
    static var repeat:    NSCalendarUnit {
        get {
            let rawValue = UInt(userDefaults.integerForKey("repeat"))
            if rawValue == 0 {
                userDefaults.setInteger(Int(NSCalendarUnit.WeekdayCalendarUnit.rawValue), forKey: "repeat")
                return NSCalendarUnit.WeekdayCalendarUnit
            } else {
                return NSCalendarUnit(rawValue: rawValue)
            }
        }
        set {
            userDefaults.setInteger(Int(newValue.rawValue), forKey: "repeat")
        }
    }
    // end ugly

    private static let queue = dispatch_queue_create(nil, nil)

    // Must be called after any property is modified.
    static func synchronize() {
        dispatch_async(queue) {
            UIApplication.sharedApplication().cancelAllLocalNotifications()

            userDefaults.setBool(Settings.silence, forKey: "silence")
            userDefaults.setInteger(Settings.frequency.rawValue, forKey: "frequency")
            userDefaults.setInteger(Int(Settings.repeat.rawValue), forKey: "repeat")
            userDefaults.synchronize()

            if !Settings.silence {
                scheduleNotifications(frequency: Settings.frequency.rawValue)
            }
        }
    }

}

// Since these recur indefinitely, it's fine if they're scheduled in the past.
private func scheduleNotifications(#frequency: Int) {
    let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
    let flags = NSCalendarUnit(UInt.max)
    var components = calendar.components(flags, fromDate: NSDate())

    var minutes = 0
    while minutes < 24*60 {
        components.second = 0
        components.minute = minutes % 60
        components.hour   = minutes / 60

        let fireDate = calendar.dateFromComponents(components)!
        let notification = TypingBreakNotification(date: fireDate, repeat: true)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)

        minutes += frequency
    }
}
