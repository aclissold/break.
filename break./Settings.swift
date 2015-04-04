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
    static var silence:   Bool           = false                {didSet{synchronize()}}
    static var frequency: Frequency      = .Every60Minutes      {didSet{synchronize()}}
    static var repeat:    NSCalendarUnit = .CalendarUnitWeekday {didSet{synchronize()}}

    private static let queue = dispatch_queue_create(nil, nil)

    // Should only ever be called outside this file on first launch.
    static func synchronize() {
        dispatch_async(queue) {
            UIApplication.sharedApplication().cancelAllLocalNotifications()

            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(Settings.silence, forKey: "silence")
            defaults.setInteger(Settings.frequency.rawValue, forKey: "frequency")
            defaults.setInteger(Int(Settings.repeat.rawValue), forKey: "repeat")
            defaults.synchronize()

            if UInt(defaults.integerForKey("repeat")) != Settings.repeat.rawValue {
                fatalError("loss of precision")
            }

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
        let notification = TypingBreakNotification(date: fireDate)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)

        minutes += frequency
    }
}
