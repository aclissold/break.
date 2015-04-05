//
//  GlanceController.swift
//  break. WatchKit Extension
//
//  Created by Andrew Clissold on 4/4/15.
//  Copyright (c) 2015 Andrew Clissold. All rights reserved.
//

import WatchKit
import Foundation

class GlanceController: WKInterfaceController {

    @IBOutlet weak var timer: WKInterfaceTimer!
    @IBOutlet weak var nextLabel: WKInterfaceLabel!
    @IBOutlet weak var typingLabel: WKInterfaceLabel!
    @IBOutlet weak var breakLabel: WKInterfaceLabel!
    @IBOutlet weak var silenceLabel: WKInterfaceLabel!
    @IBOutlet weak var mondayLabel: WKInterfaceLabel!

    var calendar = NSCalendar.currentCalendar()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    func soonest(dates: [NSDate]) -> NSDate {
        var soonestDate = dates[0]
        for date in dates {
            if date.compare(soonestDate) == .OrderedAscending {
                soonestDate = date
            }
        }
        return soonestDate
    }

    override func willActivate() {
        super.willActivate()
        if (userDefaults.boolForKey("silence")) {
            showSilence()
        } else if shouldShowMonday() {
            showMonday()
        } else {
            setUpTimer()
        }
    }

    override func didDeactivate() {
        timer.stop()
        super.didDeactivate()
    }

    func showSilence() {
        timer.setHidden(true)
        nextLabel.setHidden(true)
        typingLabel.setHidden(true)
        breakLabel.setHidden(true)
        silenceLabel.setHidden(false)
    }

    func shouldShowMonday() -> Bool {
        let rawValue = UInt(userDefaults.integerForKey("repeat"))
        let weekdaysOnly = NSCalendarUnit(rawValue: rawValue) == .WeekdayCalendarUnit
        let isWeekend = NSCalendar.currentCalendar().isDateInWeekend(NSDate())

        return weekdaysOnly && isWeekend
    }

    func showMonday() {
        timer.setHidden(true)
        mondayLabel.setHidden(false)
    }

    func setUpTimer() {
        let now = NSDate()

        let frequency = userDefaults.integerForKey("frequency")
        var date: NSDate!
        switch (frequency) {
        case 20:
            let date1 = calendar.nextDateAfterDate(now, matchingUnit: .MinuteCalendarUnit, value: 0, options: .MatchStrictly)!
            let date2 = calendar.nextDateAfterDate(now, matchingUnit: .MinuteCalendarUnit, value: 20, options: .MatchStrictly)!
            let date3 = calendar.nextDateAfterDate(now, matchingUnit: .MinuteCalendarUnit, value: 40, options: .MatchStrictly)!
            date = soonest([date1, date2, date3])
        case 30:
            let date1 = calendar.nextDateAfterDate(now, matchingUnit: .MinuteCalendarUnit, value: 0, options: .MatchStrictly)!
            let date2 = calendar.nextDateAfterDate(now, matchingUnit: .MinuteCalendarUnit, value: 30, options: .MatchStrictly)!
            date = soonest([date1, date2])
        case 60:
            date = calendar.nextDateAfterDate(now, matchingUnit: .MinuteCalendarUnit, value: 0, options: .MatchStrictly)!
        case 90:
            var dates = [NSDate]()
            var minutes = 0
            for hour in [0, 1, 3, 4, 6, 7, 9, 10] {
                let components = NSDateComponents()
                components.hour = hour
                components.minute = 30 * (hour % 3) // 0, 30, 0, ...
                let date = calendar.nextDateAfterDate(now, matchingComponents: components, options: .MatchStrictly)!
                dates.append(date)
            }
            date = soonest(dates)
        default:
            date = nil
        }

        timer.setDate(date)
        timer.start()
    }

}
