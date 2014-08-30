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
    static var until:     NSDate         = NSDate()             {didSet{synchronize()}}
    static var frequency: Frequency      = .Every60Minutes      {didSet{synchronize()}}
    static var from:      NSDate         = NSDate()             {didSet{synchronize()}}
    static var to:        NSDate         = NSDate()             {didSet{synchronize()}}
    static var repeat:    NSCalendarUnit = .CalendarUnitWeekday {didSet{synchronize()}}
}

private let queue = dispatch_queue_create(nil, nil)

private func synchronize() {
    UIApplication.sharedApplication().cancelAllLocalNotifications()
    dispatch_async(queue) {
        scheduleNotifications(frequency: Settings.frequency.toRaw())
    }
}

// Since these recur indefinitely, it's fine if they're scheduled in the past.
private func scheduleNotifications(#frequency: Int) {
    let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
    var components = calendar.componentsInTimeZone(NSTimeZone.defaultTimeZone(), fromDate: NSDate())

    var minutes = 0
    while minutes < 24*60 {
        components.second = 0
        components.minute = minutes % 60
        components.hour   = minutes / 60
        let fireDate = calendar.dateFromComponents(components)

        let notification = UILocalNotification()
        notification.fireDate = fireDate
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.category = "Snooze"
        notification.repeatInterval = Settings.repeat
        notification.alertBody = "It's time for your typing break!"
        notification.soundName = UILocalNotificationDefaultSoundName

        UIApplication.sharedApplication().scheduleLocalNotification(notification)

        minutes += frequency
    }
}
