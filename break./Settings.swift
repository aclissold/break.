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

private var backgroundTask = UIBackgroundTaskInvalid
struct Settings {
    static var silence:   Bool = userDefaults.boolForKey("silence")
    // begin ugly
    static var frequency: Frequency = Frequency(rawValue: userDefaults.integerForKey("frequency")) ?? .Every60Minutes
    static var repeat:    NSCalendarUnit {
        get {
            let rawValue = UInt(userDefaults.integerForKey("repeat"))
            if rawValue == 0 {
                userDefaults.setInteger(Int(NSCalendarUnit.CalendarUnitWeekday.rawValue), forKey: "repeat")
                return .CalendarUnitWeekday
            } else {
                return NSCalendarUnit(rawValue: rawValue)
            }
        }
        set {
            userDefaults.setInteger(Int(newValue.rawValue), forKey: "repeat")
        }
    }
    // end ugly

    private static let queue = dispatch_queue_create("scheduling", nil)

    // Must be called after any property is modified.
    static func synchronize() {
        userDefaults.setBool(Settings.silence, forKey: "silence")
        userDefaults.setInteger(Settings.frequency.rawValue, forKey: "frequency")
        userDefaults.setInteger(Int(Settings.repeat.rawValue), forKey: "repeat")
        userDefaults.synchronize()

        UIApplication.sharedApplication().cancelAllLocalNotifications()

        let notificationsEnabled = UIApplication.sharedApplication().currentUserNotificationSettings().types & .Alert != nil
        if !Settings.silence && notificationsEnabled {
            backgroundTask = UIApplication.sharedApplication().beginBackgroundTaskWithName("scheduleNotifications", expirationHandler: {
                UIApplication.sharedApplication().endBackgroundTask(backgroundTask)
                backgroundTask = UIBackgroundTaskInvalid
            })

            dispatch_async(queue) {
                scheduleNotifications(frequency: Settings.frequency.rawValue)
            }
        }
    }
}

// Since these recur indefinitely, it's fine if they're scheduled in the past.
private func scheduleNotifications(#frequency: Int) {
    let calendar = NSCalendar.currentCalendar()
    let flags = NSCalendarUnit(UInt.max)
    var components = calendar.components(flags, fromDate: NSDate())

    dayLoop: for i in 0...6 {
        var minutes = 0
        while minutes < 24*60 {
            components.second = 0
            components.minute = minutes % 60
            components.hour   = minutes / 60

            // Set fireDate to a past Monday plus i additional days.
            var fireDate = calendar.dateFromComponents(components)!
            var adjustment = NSDateComponents()
            while (!calendar.isDateInWeekend(fireDate)) { // rewind to Sunday if it's currently a weekday
                adjustment.day = -1
                fireDate = calendar.dateByAddingComponents(adjustment, toDate: fireDate, options: nil)!
            }
            while (calendar.isDateInWeekend(fireDate)) { // fast-forward to Monday
                adjustment.day = 1
                fireDate = calendar.dateByAddingComponents(adjustment, toDate: fireDate, options: nil)!
            }
            adjustment.day = -7
            adjustment.day += i // adjust to the appropriate day of the week for this iteration of dayLoop
            fireDate = calendar.dateByAddingComponents(adjustment, toDate: fireDate, options: nil)!

            if (Settings.repeat == .CalendarUnitWeekday && calendar.isDateInWeekend(fireDate)) {
                break dayLoop
            }

            let notification = TypingBreakNotification(date: fireDate, repeat: true)
            UIApplication.sharedApplication().scheduleLocalNotification(notification)

            minutes += frequency
        }
    }
    UIApplication.sharedApplication().endBackgroundTask(backgroundTask)
    backgroundTask = UIBackgroundTaskInvalid
}
