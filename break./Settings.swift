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

private func synchronize() {
    let notification = UILocalNotification()
    if Settings.frequency != .Every60Minutes { p("TODO"); return }

    UIApplication.sharedApplication().cancelAllLocalNotifications()

    notification.fireDate = NSDate(timeIntervalSinceNow: 5)
    notification.timeZone = NSTimeZone.defaultTimeZone()
    notification.category = "Snooze"
    notification.repeatInterval = .CalendarUnitHour
    notification.alertBody = "It's time for your typing break!"
    notification.soundName = UILocalNotificationDefaultSoundName

    UIApplication.sharedApplication().scheduleLocalNotification(notification)
}
